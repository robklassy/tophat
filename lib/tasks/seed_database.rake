namespace :db do
  desc "Your task description"
  task seed: :environment do
    # create some initial data

    school_names = [
      'University of the Mountains',
      'University of Colorado Boulder',
      'Hogwarts',
    ]

    faculty_names = [
      'School Of Air Guitar',
      'Faculty Of KFC',
      'School of Voldemort'
    ]

    prof_names = [
      { first_name: 'Randy', last_name: 'Marsh' },
      { first_name: 'Herbert', last_name: 'Garrison' },
      { first_name: 'Albus', last_name: 'Dumbledore' }
    ]

    course_names = [
      { course_code: 'AIR101', name: 'Air Guitar Intro' },
      { course_code: 'KFC101', name: 'Chicken Basics'},
      { course_code: 'SHH101', name: 'He Who Shall Not Be Named Intro'}
    ]

    student_names = [
      { first_name: 'Stan', last_name: 'Marsh' },
      { first_name: 'Eric', last_name: 'Cartman' },
      { first_name: 'Harry', last_name: 'Potter' }
    ]

    discussion_questions = [
      {
        title: "How is the weather",
        content: "Hey everyone, since we are all over the world, let's talk about how the local weather",
        discussion_question_posts: [
          { content: 'Weather sucks!' }
        ]
      },

      {
        title: "Chicken/sauce ratio questions here",
        content: "This is the discussion to help each other with the chicken/sauce ratio calculations questions",
        discussion_question_posts: [
          { content: 'I think I put too much sauce according to the forumla, the ratio sucks!' }
        ]
      },

      {
        title: "elder wand questions",
        content: "Hello Harry, this is for ALL of your questions about the elder wand, anyone else posting here will have points deducted from their house!",
        discussion_question_posts: [
          { content: 'Professor would it make sense just to you know, break the wand into a million pieces or something so voldy cannot get it?' }
        ]
      },
    ]

    school_names.each_with_index do |sn, i|
      ActiveRecord::Base.transaction do
        #next if School.where(name: sn).count(1) > 0
        s = School.new(name: sn)
        s.save!

        f = Faculty.new(name: faculty_names[i], school: s)
        f.save!

        p = Professor.new(prof_names[i])
        p.save!

        sp = SchoolProfessor.new(school: s, user_id: p.id, user_type: 'Professor')
        sp.save!

        fp = FacultyProfessor.new(faculty: f, user_id: p.id, user_type: 'Professor')
        fp.save!

        c = Course.new(course_names[i])
        c.school = s
        c.faculty = f
        c.save!

        cp = CourseProfessor.new(course: c, user_id: p.id, user_type: 'Professor')
        cp.save!

        st = Student.new(student_names[i])
        st.save!

        ss = SchoolStudent.new(user_id: st.id, user_type: 'Student', school: s)
        ss.save!

        fs = FacultyStudent.new(user_id: st.id, user_type: 'Student', faculty: f)
        fs.save!

        cs = CourseStudent.new(course: c, user_id: st.id, user_type: 'Student', started_at: Time.zone.now)
        cs.save!

        dq = DiscussionQuestion.new(
          course: c,
          user_id: p.id,
          user_type: 'Professor',
          title: discussion_questions[i][:title],
          content: discussion_questions[i][:content],
          posted_at: Time.zone.now,
          state: 'posted'
        )
        dq.save!

        dqp = DiscussionQuestionPost.new(
          discussion_question: dq,
          course: c,
          user_id: st.id,
          user_type: 'Student',
          content: discussion_questions[i][:discussion_question_posts].first[:content],
          posted_at: Time.zone.now,
          like_count: 1
        )
        dqp.save!

        child_dqp = DiscussionQuestionPost.new(
          discussion_question: dq,
          discussion_question_post_id: dqp.id,
          course: c,
          user_id: st.id,
          user_type: 'Student',
          content: discussion_questions[i][:discussion_question_posts].first[:content] + "child post",
          posted_at: Time.zone.now,
          like_count: 1
        )
        child_dqp.save!

        child_dqp2 = DiscussionQuestionPost.new(
          discussion_question: dq,
          discussion_question_post_id: child_dqp.id,
          course: c,
          user_id: st.id,
          user_type: 'Student',
          content: discussion_questions[i][:discussion_question_posts].first[:content] + "child post another onnneee",
          posted_at: Time.zone.now,
          like_count: 1
        )
        child_dqp2.save!
      end
    end
  end
end
pandoc -s -o ./student-book-presentation/student-book-presentation.docx ./student-book-presentation/Readme.md
pandoc -s -o ./student-book-presentation/student-book-presentation.txt ./student-book-presentation/Readme.md
pandoc -s -o ./Introduction-concepts-presentations/Introduction-concepts-presentations.txt ./Introduction-concepts-presentations/Readme.md
pandoc -s -o ./Introduction-concepts-presentations/Introduction-concepts-presentations.docx ./Introduction-concepts-presentations/Readme.md
pandoc -s -o ./sprint-dates/sprint-dates.txt ./sprint-dates/Readme.md
pandoc -s -o ./sprint-dates/sprint-dates.docx ./sprint-dates/Readme.md
pandoc -s -o ./tooling-assignments/tooling-assignments.txt ./tooling-assignments/Readme.md
pandoc -s -o ./tooling-assignments/tooling-assignments.docx ./tooling-assignments/Readme.md
pandoc -s -o ./project-options/project-options.txt ./project-options/Readme.md
pandoc -s -o ./project-options/project-options.docx ./project-options/Readme.md
pandoc -s -o ./project-deliverables/project-deliverables.txt ./project-deliverables/Readme.md
pandoc -s -o ./project-deliverables/project-deliverables.docx ./project-deliverables/Readme.md
pandoc -s -o ./reports/sprint-01/template.txt ./reports/sprint-01/template.md
pandoc -s -o ./reports/sprint-01/template.docx ./reports/sprint-01/template.md
pandoc -s -o ./reports/sprint-01/rubric.txt ./reports/sprint-01/rubric.md
pandoc -s -o ./reports/sprint-01/rubric.docx ./reports/sprint-01/rubric.md
pandoc -s -o ./reports/sprint-02/template.txt ./reports/sprint-02/template.md
pandoc -s -o ./reports/sprint-02/template.docx ./reports/sprint-02/template.md
pandoc -s -o ./reports/sprint-02/rubric.txt ./reports/sprint-02/rubric.md
pandoc -s -o ./reports/sprint-02/rubric.docx ./reports/sprint-02/rubric.md
pandoc -s -o ./reports/sprint-02/template.pdf -V geometry:margin=.75in ./reports/sprint-02/template.md
pandoc -s -o ./reports/sprint-02/rubric.pdf -V geometry:margin=.75in ./reports/sprint-02/rubric.md
pandoc -s -o ./reports/sprint-03/written-report-and-presentation-grading-rubric-COVID-19-update.pdf -V geometry:margin=.50in ./reports/sprint-03/rubric.md
pandoc -s -o ./reports/sprint-03/written-report-submission-template-COVID-19-update.pdf -V geometry:margin=.50in ./reports/sprint-03/template.md
# Sprint-04
pandoc -s -o ./reports/sprint-04/written-report-and-presentation-grading-rubric.pdf -V geometry:margin=.50in ./reports/sprint-04/rubric.md
pandoc -s -o ./reports/sprint-04/written-report-submission-template.pdf -V geometry:margin=.50in ./reports/sprint-04/template.md
# Sprint-05
pandoc -s -o ./reports/sprint-05/written-report-and-presentation-grading-rubric.pdf -V geometry:margin=.50in ./reports/sprint-05/rubric.md
pandoc -s -o ./reports/sprint-05/written-report-submission-template.pdf -V geometry:margin=.50in ./reports/sprint-05/template.md
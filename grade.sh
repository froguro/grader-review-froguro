CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission
if [[ -e ListExamples.java ]]
then 
    echo 'ListExamples.java found'
else 
    echo 'ListExamples.java not found'
    exit
fi

cp ../TestListExamples.java ./
cp -r ../lib ./

javac -cp $CPATH *.java 2> javac-errors.txt
if [[ $? -eq 0 ]]
then
    echo 'Javac success!'
else
    echo 'Javac failed.'
    cat javac-errors.txt
    exit
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > tester-results.txt
if grep -q "FAILURES!!!" tester-results.txt
then
    echo "You failed...."
    cat tester-results.txt
else 
    echo "You pass!"
fi

doctor="关一"
found=0
for i in {900..9000}; do
  link="https://www.jst-hosp.com.cn/Html/Doctors/Main/index_$i.html"
  wget -q ${link} -O - | grep -q $doctor && found=1
  # echo "${link}"
  if [ "$found" = 1 ]; then
    wget ${link}
    echo "found ${doctor}, id=${i}"
    exit 1
  fi

  echo "${i}"
done




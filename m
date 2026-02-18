Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBD51A23AC
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Feb 2026 02:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771381811; cv=none; b=Uu2WihjueWWE6SGrt0GOXdpGcuHAlSrmEJcgFhsZZwF7P68yxRAWNHvFavWhBYW3KT5U1pOIj5/o9s52NMAXVMc3HjNWQ8Kjf9LmqMr98UsmtThQspi32N39yE1OagymSq1PdU94y7wlxA3Z1kiLsmLyQk2HxP5LBaw3zLofRsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771381811; c=relaxed/simple;
	bh=bASNRAZbfVZpJ+YdWlm5a6dcjNAe8icpKnTflaiIduE=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=Pqz6c1H697U9vaUiWjJ6Ja/iFXb6kIMbZQvS7GPFG6hS/q3cq/xZMf0is4BhBykdnzeHBBY9sFxsHYVe9kXE77zvFZ28F5WjhELMKXzNWWsSdg2bY7OIVKgwRlPdu/yG+3Ihxwg+4sw+74q8E/UGy3tPYFBNEt2JEkUdM563DLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=THLh9FVk; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="THLh9FVk"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2bd3b0bc201so1587355eec.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 17 Feb 2026 18:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1771381809; x=1771986609; darn=lists.linux.dev;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Bx+e+lc2SVyVj908TYJ3wu2vBOtaWKCZcQcgbVTUTs=;
        b=THLh9FVkxsT1qVw8F0n17llW57LUH2vcBwu6uoeM1xlxUKIps9NiqJdwtsosPobr7c
         3+QRO5p8jN1C4qziL1hQIBqOj+hsN3115ncJo/+H9rpUvK6cuuR0LRrdJG/xPSPzLMmE
         /deYXwOrCzEIWG7PuqjbR+8hxvBX0EgUI4PIjI01i+g+w9532/diboXTgpZDRP8IwGbf
         Zr9QtKgMQ8i/CMHPRo0E4wDkQkS3ESj9XS0KMvfqjVn1dZ/E+/1APjfjbkEhjMnSHRmQ
         a8U96uuYv6N1mseOpllVdwFRpJRB1COCSTIv0wIFscKzPMji4C+UQ7NTHSgIzzXO3Jjf
         PBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771381809; x=1771986609;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Bx+e+lc2SVyVj908TYJ3wu2vBOtaWKCZcQcgbVTUTs=;
        b=AR4AdFy7Cl8iyACuulBTGXTgTZ9DTylsnIm66yTzJXyQTZWzDmHCye2CRGaNh8Qsux
         iVQjcLNGi6K30Eo5VeLvKI6DLMn1imYFMmSwJOEhFqGoc/kHQLBz38U4eG1CFDyc76YE
         zmggww4C9J0vrDp6FUN70GFR6Qguyd38E3W+w1IFKtpueeMlQm+CthTLcO2Fe6+NT3gO
         /h75XHLV0SCjA6gUjhwPc9+QG1hs3ijmlYL47QTQVQ0TkrLXS50G+86zq/aHbggfGOgS
         YypZNtzWvHWI1RC3VVi8v/BXy/d+t9juL9FMzq9o06qQaRRBbIE7hQvcMEr2cwBfu8gp
         aczw==
X-Gm-Message-State: AOJu0Yx9Qjh7XFmx9CEMQA5u382i5iWlkV+848X+EKEI5sgKyzAUOxy1
	iPtylIve3CJ+QpWc7xbAW+7yESyOFOHZh/H3f3Qx01uohIbmIjb+H1R98fviAkCropg=
X-Gm-Gg: AZuq6aKeHFpt2rmhDONuEqUoB2z7nQEDnQRh8tuEAQO4VIn6er1S65/rUSLHsjRCno2
	SjJ7hvViEiDWgHQU6AepU4WUKgas5GoWXgXqIyZPWmC3kuLRsORovxR2npHslRa8rDFLgm0Eq1c
	RCPSPflTPHuHJT/PRI6BaU7PqeMlOqN7Am2SXdJAuZlppYPV+qM5qCN59oI/CleXOKH6dEQAV6y
	wlAmqPYE+W6ijunap7LYY6YefKx9i+f0eLUiiROiH2jhAMNlz2YqvMGG3Abt5UFljaEWYoE6OI/
	kDDyAshCjpnuz8B4ya7LUW1+axdT8M1jMGP5UV0UgL3Odq7z4USepdnK7npZ4u4NGnie9UYs5Mc
	Ye/jg570OrIt4EDkg56OTTvaB3+EtmSHQ0mZCpgBmen4AYLr5fFzvmGh7C4/GUpKLgjs1b4JnRS
	UElISBDsl3H/6WCHuV
X-Received: by 2002:a05:7301:9f06:b0:2b0:5c2f:6bf8 with SMTP id 5a478bee46e88-2bd501871e6mr282160eec.23.1771381808761;
        Tue, 17 Feb 2026 18:30:08 -0800 (PST)
Received: from f55b40a4666e ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb67b638sm16953347eec.31.2026.02.17.18.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 18:30:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable-rt/v5.10-rt -
 e1c3ac4207efdc4bd22fe82fef0aaa0ad1d8efcf
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: linux-rt-devel@lists.linux.dev
Reply-To: kernelci@lists.linux.dev
Date: Wed, 18 Feb 2026 02:30:07 -0000
Message-ID: <177138180723.3393.14273536837313312829@f55b40a4666e>





Hello,

Status summary for stable-rt/v5.10-rt

Dashboard:
https://d.kernelci.org/c/stable-rt/v5.10-rt/e1c3ac4207efdc4bd22fe82fef0aaa0ad1d8efcf/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
branch: v5.10-rt
commit hash: e1c3ac4207efdc4bd22fe82fef0aaa0ad1d8efcf
origin: maestro
test start time: 2026-02-17 14:07:36.716000+00:00

Builds:	   21 ✅    0 ❌    0 ⚠️
Boots: 	   26 ✅    0 ❌    0 ⚠️
Tests: 	  125 ✅    2 ❌   41 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: qemu
  > Config: defconfig+preempt_rt
    - Architecture/compiler: x86_64/gcc-14
      - rt-tests.cyclicdeadline
      last run: https://d.kernelci.org/test/maestro:69948079a1ae387ffbdea098
      history:  > ✅  > ⚠️  
            
      - rt-tests.cyclictest
      last run: https://d.kernelci.org/test/maestro:69948078a1ae387ffbdea092
      history:  > ✅  > ⚠️  
            
      - rt-tests.pi-params
      last run: https://d.kernelci.org/test/maestro:69948082a1ae387ffbdea0b3
      history:  > ✅  > ⚠️  
            
      - rt-tests.pmqtest
      last run: https://d.kernelci.org/test/maestro:69948091a1ae387ffbdea0d5
      history:  > ✅  > ⚠️  
            
      - rt-tests.ptsematest
      last run: https://d.kernelci.org/test/maestro:69948092a1ae387ffbdea0dd
      history:  > ✅  > ⚠️  
            
      - rt-tests.signaltest
      last run: https://d.kernelci.org/test/maestro:69948082a1ae387ffbdea0ad
      history:  > ✅  > ⚠️  
            
      - rt-tests.sigwaittest
      last run: https://d.kernelci.org/test/maestro:69948085a1ae387ffbdea0ba
      history:  > ✅  > ⚠️  
            
      - rt-tests.svsematest
      last run: https://d.kernelci.org/test/maestro:69948094a1ae387ffbdea0e3
      history:  > ✅  > ⚠️  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

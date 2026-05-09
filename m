Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BEE2F8E9C
	for <linux-rt-devel@lists.linux.dev>; Sat,  9 May 2026 02:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778293837; cv=none; b=cV/gR710SwAaG9j0e3wCIYTyPp9MOYNhygtRBb+YX+hqt6ue1HfJ6qithUWOLAI8gkek3bwXUtVBnLMotgvn9GaMhZLBmSzi2aSPNM/yGIP2xpVwKp2K959sWL8ec+UlV9V8hk9rsCjmuqNNxpXazJtbmmm2RWNv36+kQtG2K6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778293837; c=relaxed/simple;
	bh=ui+euKLkV4IMY5sh0Y/BcVnZNfHsXw/8DxoDwyCe0iM=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=gt7YrFvUW41asc3KxzjjarW0UNp9WJkDUaH1+jpcVrnf/fKtMMSGRSeAy2IqI4SYJhLlnN/go2Kuej2M3XaELk9dCYjflMQ+PMz45ju9/lqwXHT4jTVMfsT6exvJ49qwdKGo6a3iurSjxiHKDR3w8V1WiVIMwwyZeFMt04fORt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=Wuxdmpn6; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="Wuxdmpn6"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b4520f6b32so4868099eec.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 08 May 2026 19:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1778293836; x=1778898636; darn=lists.linux.dev;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0uoY2+QbvEJa9ctVf0dWVpanID8eWIpJANVjaFSULE=;
        b=Wuxdmpn6kpmzpgQLNzguZvXz1xPelTW/BIGAznDgmS3CX+oLUuP6Jbd30HLHC18/nF
         B9Nihk5U+Kz5ScPfa3icMLOCdrfsc24zmLzfFG0vmVL/TCgsx91bIW72QT8tQMi87KJs
         N5dWbPnS5ToQL74DLAqK3tFtZ8r9fVPpHHikljRsTd8iCh6KXPFZ53c/KEG1+aDSCiN8
         uWNQIpbWFVoRIzuEBKY5QmYAWINzm4Q4/Q6HwoS3V+yNu0AQwEWO4FYJnkxIhEGZ6piQ
         uEtdIsamqfYB+K9tU5br87ktMTMXF6BfLL9jlh7mZ31seE0gua+Vw98DB0sZybKCTrqJ
         9gJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778293836; x=1778898636;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q0uoY2+QbvEJa9ctVf0dWVpanID8eWIpJANVjaFSULE=;
        b=kG4nfcbZyIF12NmGHvCKdE8x8U0TBSfHYIbJ7Ng1BE3dg8PWvJ7EfWES2PMfxER5am
         UJnKBlWolYJEUrVqraHTG3LrAd14hh8IeLMPthhELjGNrAX3GMs6QTE3R0+7adb5xSnH
         TJ9nTHMAWgVthN15V/L+RMTkIRp7qJJNfRCsw6Q2Q40MVomV9fTRUv5U7tX03CWJq4xD
         ugQkBDY6VT55Xlco0ozcPYFc1qGq1Ng8myoz/632vkhLt82Cf9JDrjB3ybXffeMU79RZ
         AyECpue1MuEpvuq4igHRFI34bK2ZsMRvUCw1i5mccXU2Zis5FYVo8KTbws2U1twFu46G
         bQWg==
X-Gm-Message-State: AOJu0YwSF1I7706XF9cBEtjenbVES7jHCxkVJX185R2GHBkMQSRllbKD
	/dDRUNKk6VHKSPF6Zsus0Ms7R+cuaWjbQ9dCJRbEkkFaz8k6nY1HT+ZZBc0FUaCVJaCdIiBj5me
	vQ2ym
X-Gm-Gg: AeBDievgieMKK8lAZxMgKfykdIzDf8j+hsIcjVyYaEHqNkfqsjZO/Cbh0h+dfBnB9Pv
	pTamn+thBtBH8PCMibON7xPxQVoVkGf2yy/96PseUzWodCFqThL9pqJAECHbMiYQIqpwEMCTV8k
	0em3qDhKFx3gX2cODFkS8kDC+CSO0hnHVL61qBkvARbGHTcXu+6MOe4cUOsJbhmsKOrurQaUwKX
	zDhRVXR/XRd1zyAiRZh96qFOTJk9KJWjrNq+qyXGM8unMaEre7xuHvWx++Jx85NLab+r6VRqeHv
	9n46sCNWRmk+xKZb9bAkfvbzLrtyTpRsI0Iq6SJ69EUosmbZxxWL8uHWx6lna9V3yGFhdXJ9cL5
	kRU1Tw148EgamG/8Sqji/luxkAItBo8+2Wx7LF+1duTGX7i7cctUJlRatXMVkDUl28G8EYAckN4
	O8Ymkny5uB7HC1V8Ic
X-Received: by 2002:a05:7022:251f:b0:127:5cd6:fa45 with SMTP id a92af1059eb24-1319cc19f1dmr8531094c88.14.1778293835318;
        Fri, 08 May 2026 19:30:35 -0700 (PDT)
Received: from 997d03828cfd ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132787673ffsm5947915c88.15.2026.05.08.19.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:30:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable-rt/v5.10-rt -
 f890d3d2d43123238f1102e6c8ea96d75103cac9
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: linux-rt-devel@lists.linux.dev
Reply-To: kernelci@lists.linux.dev
Date: Sat, 09 May 2026 02:30:34 -0000
Message-ID: <177829383450.4454.1598216598838978743@997d03828cfd>





Hello,

Status summary for stable-rt/v5.10-rt

Dashboard:
https://d.kernelci.org/c/stable-rt/v5.10-rt/f890d3d2d43123238f1102e6c8ea96d75103cac9/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
branch: v5.10-rt
commit hash: f890d3d2d43123238f1102e6c8ea96d75103cac9
origin: maestro
test start time: 2026-05-08 19:58:20.303000+00:00

Builds:	   18 ✅    1 ❌    0 ⚠️
Boots: 	   24 ✅    0 ❌    0 ⚠️
Tests: 	  275 ✅    4 ❌   25 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: meson-g12b-a311d-khadas-vim3
  > Config: defconfig+preempt_rt
    - Architecture/compiler: arm64/gcc-14
      - rt-tests.rt-migrate-test
      last run: https://d.kernelci.org/test/maestro:69fe45a40e4ee292cbf329e4
      history:  > ✅  > ❌  
            
      - rt-tests.rt-migrate-test.rt-migrate-test
      last run: https://d.kernelci.org/test/maestro:69fe46060e4ee292cbf32c4a
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: rk3399-rock-pi-4b
  > Config: defconfig+preempt_rt
    - Architecture/compiler: arm64/gcc-14
      - rt-tests.rt-migrate-test
      last run: https://d.kernelci.org/test/maestro:69fe45a90e4ee292cbf329fa
      history:  > ❌  > ✅  
            
      - rt-tests.rt-migrate-test.rt-migrate-test
      last run: https://d.kernelci.org/test/maestro:69fe48650e4ee292cbf33085
      history:  > ❌  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.



This branch has 1 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3017F1EA7F4
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Feb 2026 02:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771554609; cv=none; b=evLpXeNeiuv6n2esw1Mojo9JyTKC+aVSPj8zZNnp5m2UMrwOhTVO/xJ9TcAf9FcsorwDFFI+y9E4x9xOQ1+SpxEvbwvWV4xKyBbPqZbPxv/C7j63T2IrU4r8nmj7qyUgZLI3qfnEKuZlBpgF9xBTpzdK+XBTz1i2Gfq4h30uByM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771554609; c=relaxed/simple;
	bh=+4QnuOhWW90i1DN8MpGHopEVGmTTKTn/UixJEo90U+o=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=nc/uaWhC0/kRur7ukcg1I5YFX8DQhlFoYfu2k9KR6/YVHMz7sRlHpItuTtZZpTnz1mQC6FT2uFS7x0cGcK0j2fSPKIOF6w4pnU3Ae81YgmxrNRX/7BqV0XYe6YkfV1Oe1BU9rvIbDwHuuk1cUzgspE6hU5DS0GFZEtI6szNDhW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=GZ/Zaz4j; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="GZ/Zaz4j"
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-1270ac5d3efso1530936c88.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 19 Feb 2026 18:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1771554607; x=1772159407; darn=lists.linux.dev;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDN6vvLwEa9QPG1zsasa3KXviQ+qpOYvq8cMieCgLPs=;
        b=GZ/Zaz4jb0C1pIqo4fAhQhIyWra0eOMzJ05BH5293suCUAoM7XKAM80+6UY8kKFaJZ
         5wi/wOOe83AWfObRJreGWqbHTBw18mEcaQmsxemSuec443WdTpnQDscBCGOjUxSBcgZM
         JgTaGW+RVsKdaoMSqz9EmapTFObwj7Ehib62rlXSyA9d0zm/aO3FL5a2bLGALCAU97iD
         jnjwujIhT/h3Y/5zZDIvGWH0x4A7+ATNRnrv6VRfWIjyYgyxiMKNez2SqlSwSQXFQn9u
         5G1vg5AxCngMFN8cUPEquEXdgc/QyH7otz+20xIJpek+bJpVwNuH9vI0ZU9T/b4THaaq
         04pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771554607; x=1772159407;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dDN6vvLwEa9QPG1zsasa3KXviQ+qpOYvq8cMieCgLPs=;
        b=bxVC4egmY7MU+NtFLmgMLCBaDiX7gUAK9cK02dQL1pmPhI5gxeGhY7zG8Oi3l2krZK
         bQAaZHeZDHcK+J5LSYxpJDUuywgGHgLmFpTmOUA/P1pkLHmhW2aiAu0G4NVafaHAV6iA
         XC65F53Vb50BFJjLfBlg4JPlETAIBzi3rfuJYccZ4N/fb74WsDq7cnPESHseRU/1e/8Y
         FCXrJsGB5Wg7KL/5hTj+dEfqXea7tesBqkZ707kHDrvygP85IYTbqJ+A2BJAczLvPdQZ
         MxadkiPr9ITzrDqGi/XH9oSEeL5Pm8I3hWp8ZfAqZf4pkNSIp+MA5Wqj5kMs/SDqAKaK
         BphQ==
X-Gm-Message-State: AOJu0YzADNfjaPx+5dgcUFTMQLrFku2M0ZxI1GOeeIQnl8nUN8pK7S0x
	zCxpffROMQ4MWCz8NTZPfZBKKAEHN4sflwhAX/42SdOiZK0s9y7dtu54yZ+9xTVCn99kG2xO/u5
	rFzxOW5o=
X-Gm-Gg: AZuq6aJjKfoEEYqlxfBJvKCcieEaw6cYC60oVW7rtGe0w4Omuc2ega0/VcDn4kNeYS1
	HXXO+QpkpNd18tZosz+7InjhtqUycUuytLwTb33s4obMrFpGslVbXQIpbDOgKebj2uWnHuHHMBb
	BluxMlsZAIKYrWMJU8xSLoNmAh1NJdhTGJxK2mPlM+O4GpKClgN6llpLp4z7IxUDOo1M2uCFstg
	Sk+AJWJXm0hsQ2qbjHDcncc3aR4VCAfiTFXb/Pv9/hFIq4tLx05Bm8XKmQdelTP1ah34IBdDi6H
	4KmCOrxItu8H6zrN6JVfOkptJk+9vemnjqdbAW1/JjYKjX9hmGAOVxyz7mutYD0K4EgFpG1pTYW
	TiWZY5r7VaqZuNXoxM4h7KPX1Odl8WYiDCUstOPdAFI+VMh1yBhzRA7eiBd9P/thPCA3c7NRQ0p
	E9wb/nutFJOkq4FQ3H
X-Received: by 2002:a05:7022:4389:b0:127:3214:c869 with SMTP id a92af1059eb24-12741bd5001mr6552379c88.44.1771554607154;
        Thu, 19 Feb 2026 18:30:07 -0800 (PST)
Received: from d14e337afe00 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb658fb9sm22255546eec.20.2026.02.19.18.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 18:30:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable-rt/v5.10-rt -
 291e6d8d18589f662e9e02185277222f4d7bed4b
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: linux-rt-devel@lists.linux.dev
Reply-To: kernelci@lists.linux.dev
Date: Fri, 20 Feb 2026 02:30:06 -0000
Message-ID: <177155460591.304.13551877130171425580@d14e337afe00>





Hello,

Status summary for stable-rt/v5.10-rt

Dashboard:
https://d.kernelci.org/c/stable-rt/v5.10-rt/291e6d8d18589f662e9e02185277222f4d7bed4b/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
branch: v5.10-rt
commit hash: 291e6d8d18589f662e9e02185277222f4d7bed4b
origin: maestro
test start time: 2026-02-19 15:26:16.425000+00:00

Builds:	   21 ✅    1 ❌    0 ⚠️
Boots: 	   34 ✅    0 ❌    0 ⚠️
Tests: 	  290 ✅   78 ❌  416 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: qemu
  > Config: defconfig+preempt_rt
    - Architecture/compiler: x86_64/gcc-14
      - rt-tests.cyclicdeadline
      last run: https://d.kernelci.org/test/maestro:69972dab7b34c33055395075
      history:  > ✅  > ⚠️  > ✅  
            
      - rt-tests.cyclictest
      last run: https://d.kernelci.org/test/maestro:69972dad7b34c3305539507e
      history:  > ✅  > ⚠️  > ✅  
            
      - rt-tests.pi-params
      last run: https://d.kernelci.org/test/maestro:69972db07b34c33055395084
      history:  > ✅  > ⚠️  > ✅  
            
      - rt-tests.pmqtest
      last run: https://d.kernelci.org/test/maestro:69972db27b34c3305539508d
      history:  > ✅  > ⚠️  > ✅  
            
      - rt-tests.ptsematest
      last run: https://d.kernelci.org/test/maestro:69972db57b34c33055395097
      history:  > ✅  > ⚠️  > ✅  
            
      - rt-tests.signaltest
      last run: https://d.kernelci.org/test/maestro:69972dbf7b34c330553950b6
      history:  > ✅  > ⚠️  > ✅  
            
      - rt-tests.sigwaittest
      last run: https://d.kernelci.org/test/maestro:69972dc27b34c330553950bf
      history:  > ✅  > ⚠️  > ✅  
            
      - rt-tests.svsematest
      last run: https://d.kernelci.org/test/maestro:69972dc47b34c330553950c5
      history:  > ✅  > ⚠️  > ✅  
            



This branch has 1 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D89F4438B
	for <linux-rt-devel@lists.linux.dev>; Sun, 26 Oct 2025 02:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761445847; cv=none; b=UGjno3p1kVlbXzBbedMVadp3MjGSWbyKMZH0aPlSVIFAK7Nr1T8lZemV3w6ROXOgtSc4LU3bbvpwNxnQth9S3R4LUAQasPb7iDdEFO0Ne1YiCm4y/KqLS8gvBHxEdjX7Ggbmqj2ww5uDzWqo6qwHfpBXWuG+eL0Rnx0UwBSfs0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761445847; c=relaxed/simple;
	bh=rmC6WL3AD2CKSHlL4rHzAEFFVCM8eLVfJQpUY2O4hGM=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=kDyWbx334a12sv/yM7SNQne1XIV26V7rNKOCinja8hJjfy0Ga9hU6318Au9MHhH6UXiZVp4WV2QWcVxRHA57IU72ZFnS5V18ll0/Yu0s+F3CpUDaR7o4LIcp1ewfM6gfnsv/yPau/r05Z3sOUaurOI/HWHPcG8dhRdXXzcS+ubw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=ao4RiOJi; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ao4RiOJi"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33ba2f134f1so3269531a91.2
        for <linux-rt-devel@lists.linux.dev>; Sat, 25 Oct 2025 19:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1761445845; x=1762050645; darn=lists.linux.dev;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7aI+ljGEtytqtn8yzL+I9188t3llK+xjuHX79rQymQ=;
        b=ao4RiOJi63WTEp11zKqMjoaFW1XUMX6RrS7/gFse+stbHOhl3TJDZHdDPzzTIgqgos
         jHyDMV0b3KlB3I4HMMiKgIdhM+ZXUJMUJcV0exjOtiT5b2kLU5Wu6fz5Khg7hqCBfKyr
         x8BXEHxOGIELQcp8EG51pUW8z8oFQuNa+PyVg6YXMhzlzrZUUXKSLBXvx3NbTYzmwlcf
         cJKCHPIUg6rhaBDuMv7/D1QXeX9Ycgt8wvDjzvkchDcTR6Ld5NcjZikfWPTb4p5Ff/W0
         gvv36M7TDJ2YN+t4f+Jpetp8fiV/cDqhoXtMWWTbSa3G29umISNcRe5+PR/541F6Yeu2
         ndTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761445845; x=1762050645;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G7aI+ljGEtytqtn8yzL+I9188t3llK+xjuHX79rQymQ=;
        b=aHT+iw+CE/TkgRXkp0nWp4t9hY5TtrcGGBW4avzpjWU0niYZ2bzw0vC5K15LK4rj/w
         l5zJNs8hyQnluXR61pk9ibOU17EELBKiEnzqmsIneWhh2+oOK6Pt7WCi6MQUkaTMOQ0w
         yk8z+hWebaiy8oVJyUuFDmedgP73Ycnoe93tKPMwItM/Pk5tOIenBGhxIwMeRwMiC2+T
         4CT1N47k85BqY2aVRiAaAD3FiOKIUgpO+mFFZQCjLgfCSneShGgKHoRBG99Gq7sMxlOO
         1RjS8tNVoLdzPLozFlaaJVjdIDMjAtarEJrbZ+8lZum3lUpsd/XCzp9SIa1XbrbzOZVm
         GvbQ==
X-Gm-Message-State: AOJu0Yy0CS/E6jaumNZWnN8og6TZjqAjzLjqzWrqsGk8RxImEMXQfAIx
	a3AcpJWetdfe+vTCBgTR5Vge91Ca0J21wcJXofl+CQcxDxzlLdjVEHB7ouyxyHHxraA=
X-Gm-Gg: ASbGncsXZ91J0IQTznUE9F8u00CSJMRDXwB/wkG+KpLN03HShrAn1mNPEmZSV9aTJ0O
	uZQDbfI33AiwcFZwHAPkmUUenk6HBMKmsTpKaOCQNauxG+2Hz3UbHJkIYwlWeEV/fHQvbjfUxSq
	/SG2+EBM7GjLKmmwDDcQHpCgdpnEWOJrZGn3Fxkx4gJjpe13BiJSvXWk3ZSfNXjSpHtJ3gtOHDG
	vHdZDcOjW0RdgszUCpcn5iEBIsWzy/hEXDFAk/fiZacMiaBjTuXWvg128ZrqFV7TDBqC/KvbmZ2
	ICJKa1PFNQbOp+kx2clRJN7W/U5DrQj68OufKYMQMwir619MNsb6D9EyCfV3PKvg9ULrvT9hNUG
	XHjoll5S5uJmXvpDZ6dXqv40tCFJenvPH3D7HVfbf0B0OhAVO0Ed4Ql4xn7r6eQIbklGOsQ==
X-Google-Smtp-Source: AGHT+IHf1N2T+ILPnXqvwS5t4q0I/+53MHAI7ojM+n85EB1CU1jH6ePWwlEjUQr6UpJVm9zg7TngfA==
X-Received: by 2002:a17:902:dac3:b0:293:b97:c335 with SMTP id d9443c01a7336-2930b97f30amr158460455ad.10.1761445844658;
        Sat, 25 Oct 2025 19:30:44 -0700 (PDT)
Received: from 15dd6324cc71 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b71268be14asm3277466a12.4.2025.10.25.19.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 19:30:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable-rt/v6.6-rt - 8730bff5e3fb6244ff05722adeb890c928444cca
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: linux-rt-devel@lists.linux.dev
Reply-To: kernelci@lists.linux.dev
Date: Sun, 26 Oct 2025 02:30:43 -0000
Message-ID: <176144584329.7108.16481632862033705415@15dd6324cc71>





Hello,

Status summary for stable-rt/v6.6-rt

Dashboard:
https://d.kernelci.org/c/stable-rt/v6.6-rt/8730bff5e3fb6244ff05722adeb890c928444cca/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
branch: v6.6-rt
commit hash: 8730bff5e3fb6244ff05722adeb890c928444cca
origin: maestro
test start time: 2025-10-25 20:10:38.313000+00:00

Builds:	   21 ✅    0 ❌    0 ⚠️
Boots: 	   38 ✅    0 ❌    0 ⚠️
Tests: 	  877 ✅    2 ❌   80 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: meson-g12b-a311d-khadas-vim3
  > Config: defconfig+preempt_rt
    - Architecture/compiler: arm64/gcc-12
      - rt-tests.rt-migrate-test
      last run: https://d.kernelci.org/test/maestro:68fd34a2417a3386b1d67925
      history:  > ✅  > ❌  
            
      - rt-tests.rt-migrate-test.rt-migrate-test
      last run: https://d.kernelci.org/test/maestro:68fd3567417a3386b1d67a55
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A961F2BA4
	for <linux-rt-devel@lists.linux.dev>; Sun, 19 Oct 2025 02:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760841038; cv=none; b=Aa2ICTpOy8ueeiLFeYhWU5k8VNUrPxet6ZZztYs5ffo0TjPneDSkGywdP+sbUT3byhxEfh5s1tIzMGqPuTJlfPF984ImCKE81m6aB7/HYDa5II7mYsSWAOs5kR8X807AlkNHoCP5vAY79i3Lhd+r+kR3sckZR4dRyFIPptZTnlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760841038; c=relaxed/simple;
	bh=2R6US3cZaDiP5nkNfYVYDLPHmace1a1u4wtYi+RZrU0=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=MKM3wGn0S++Pcvk4Sw7KQ6zjVlLbuSZCrXJHIL2ijdv3NGQyqgVZ/vm8oYEVlDdn9NlL9SroppA9sMGJiwRKst6od/OkcacHyGLCUFc1ILmEcrvKf+mxJXpsmrxYKs6FiKC4zHf1ZbFtF90eQC8EDKdbhUHTup1faSna+l8ztKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=DMpI6XNw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="DMpI6XNw"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2897522a1dfso31896745ad.1
        for <linux-rt-devel@lists.linux.dev>; Sat, 18 Oct 2025 19:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1760841036; x=1761445836; darn=lists.linux.dev;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ix3jhSd3krKC6Re+ZDl2Wagsaybp3C9qjxtKnZJzgcc=;
        b=DMpI6XNwzEIgKU4jBwKTOXNGtYKnVCZLR8afLC+Gm2fOyH4BpdsuFGy3U0kYkyQPCu
         c6nbXIOFz28kk8wP7uh/1Jf0k2u0BXxinEfg421jHVsttk7MXo6k3t14br1zjdGg5AIA
         tilEdsXI5RY4jfWAeLHtTuYU0+oqlzAlIozmBR1fyGZXEJBqDJmeGFLDN/W3dBRhFI65
         xBnrlXQ9Qf6qt77kznJ7WUyQfm5bekIjVVf9nQLhTTZV6OeBs3Fq++7My8ptTkvCk2Q2
         Og2LmyPaDMdY1DJjq7TlyPSMKSqcy5DhdusToWn0M+V4P1Fni0M86z/XqJpVMNXbC6cv
         qeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760841036; x=1761445836;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ix3jhSd3krKC6Re+ZDl2Wagsaybp3C9qjxtKnZJzgcc=;
        b=HdnsjXlcUKdyN2vFKmsqYnW9xNxXnwWI6jC6OUG3jaQhhTw+ZMlM1Ym1T6B1lqSt0L
         IVpupMLlGrYTO/X9cwCP1cX9EC/SBE+5iMI4IELEPT6NGKrcvAQHiCjkRzaPUc75Jbs6
         a8ekQLCrmaterNE0K6TgBeJ5GnqOn8h98QeeniWEaxKVKYBmLrXXR3qPak2OUBJ6xUCk
         QRavRf04joqc5+gjvgbY46+Y6it4xiL+JeODobqzYjZLDUSoOG20g0yuG/aYtU0KPf81
         SuPcnw7eKpTB/JSyZmDcK5OiUjSlcSQeAp6Rhkd+xAYpVHpyRQag9zkWqaWoCbJjDzz+
         elOw==
X-Gm-Message-State: AOJu0Yz76o5JFYoID8bWHVpmLfTkzwPl+FElYTtveJqEaGPQILpVlbaR
	Etz5t5NR0KbgKitBBPWvHerqVQJpKAguMjQd6q6Jt8/QWJQ0cfO2EChVYmbvZ/RIgaB3wrO9ifq
	5cHDb23Y=
X-Gm-Gg: ASbGncsXElfAn8wYqwvMCfT5df2qi8Qm6psheei+VvtaswZHnyhz9ho36kzjZOhaSUk
	AT6luwvfwFdbrdxm6hXa7mvK5ogjiWxvsQo581x83dUpzbHOMDWRzvjs8hqRO/aKZVqyen7m+9l
	7uX58uLULKlpmWP+fDGtbzIEaPlUZO9XvTToG1X0E4zOh9q6wQ0IQlcyhoLdDjd7Xwd/9q9u6ZC
	5RS5siUndPkNnfvUvWUN6nT5wB0Zwr2Qrsgi7hDgvZ7lHsDLPe+pvD16Enyy131cSyLXXmvQc/i
	NyUyXGxyc/apq8In+QdDdmtgL/Pigj5Vqrx/hKwBDV7efROusnWRcR0EbsNM/NzG/viZglnlfZR
	uKNBSjhmx+GzAFWYvmwlM8+Tkj6XRAJhrxzi01jN0seWiFnvRX+aze6iwo9/idUjCXubnTj24Bo
	SvBgeZ
X-Google-Smtp-Source: AGHT+IEU+FtxKf7OzMM+4wF7RbIrz3wOoljqqGEompfqB4DiB5N9l9tzSXFTuL0GVRPL4emzFTo8pg==
X-Received: by 2002:a17:903:8c6:b0:290:d0fb:55ab with SMTP id d9443c01a7336-290d0fb57e8mr97124875ad.50.1760841036002;
        Sat, 18 Oct 2025 19:30:36 -0700 (PDT)
Received: from 15dd6324cc71 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292472197d3sm38856045ad.102.2025.10.18.19.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 19:30:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable-rt/v5.10-rt -
 7a9ef2cebfadb557a32d8fed925475de07f9ef86
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: linux-rt-devel@lists.linux.dev
Reply-To: kernelci@lists.linux.dev
Date: Sun, 19 Oct 2025 02:30:34 -0000
Message-ID: <176084103461.3883.1283309494314992515@15dd6324cc71>





Hello,

Status summary for stable-rt/v5.10-rt

Dashboard:
https://d.kernelci.org/c/stable-rt/v5.10-rt/7a9ef2cebfadb557a32d8fed925475de07f9ef86/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
branch: v5.10-rt
commit hash: 7a9ef2cebfadb557a32d8fed925475de07f9ef86
origin: maestro
test start time: 2025-10-18 00:52:09.074000+00:00

Builds:	   55 ✅    6 ❌    0 ⚠️
Boots: 	   80 ✅   12 ❌    2 ⚠️
Tests: 	 2122 ✅  178 ❌  327 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: rk3399-gru-kevin
  > Config: defconfig+preempt_rt
    - Architecture/compiler: arm64/gcc-12
      - rt-tests.rt-migrate-test
      last run: https://d.kernelci.org/test/maestro:68f394435621556c1f224027
      history:  > ✅  > ❌  
            
      - rt-tests.rt-migrate-test.rt-migrate-test
      last run: https://d.kernelci.org/test/maestro:68f3979f5621556c1f224358
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: meson-g12b-a311d-khadas-vim3
  > Config: defconfig+preempt_rt
    - Architecture/compiler: arm64/gcc-12
      - rt-tests.rt-migrate-test
      last run: https://d.kernelci.org/test/maestro:68f394425621556c1f22401b
      history:  > ❌  > ✅  
            
      - rt-tests.rt-migrate-test.rt-migrate-test
      last run: https://d.kernelci.org/test/maestro:68f394d65621556c1f2240eb
      history:  > ❌  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.



This branch has 2 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2251EB9F2
	for <linux-rt-devel@lists.linux.dev>; Sun, 19 Oct 2025 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760841036; cv=none; b=fTOOh5xwJTwCN93sKu78uIOoRxjMABy+xhRCDaetkdISiVf1hmQWlbIH2Z7T26icqMSb5BsZ6Dx0voTgaTlRp8xchHvOzSqoLBSGYMAD5VStZKEOxexE9KqFL/+2nHvmwlAF5TrrzscJEsbY7fSYS6KE5Q7f2zC74yCfb4vLnG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760841036; c=relaxed/simple;
	bh=tG2G/3oVlfQbQeRqbPqD6MRUuh6y/f4Lrf2IWvZ1RF8=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=gJfm+0RNmjaVAAB2hr5ntrkh2W7EgItdhyY/weEep9qtq7BsIvYCNs1LaedARnpo3x5VddZwOjDSBJg0no7POGfAB6kfeNsxAIFW/45JZ7DhSeanrRGInn9nHO8RCeOP+tA+t5Rj22Q7S747BuGSqpcEGdaEQRB4LNQeVRzRpkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=MsO+novo; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="MsO+novo"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-793021f348fso2914058b3a.1
        for <linux-rt-devel@lists.linux.dev>; Sat, 18 Oct 2025 19:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1760841034; x=1761445834; darn=lists.linux.dev;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAAYZ47bhgfxa75z5uHIphaVPwGXcOfi59M89qtfwjo=;
        b=MsO+novoEKcbjxElFmLo10zGWy2scGqixHNyXemA7s6MJ/jyrHYlirNayz5GN+8TKY
         ttcThcSYj9ya60/Zj3yvOFC8awbHh8OsLEQ28SW885Vo2D2j2be96nuhjHiGu+BbbpYi
         JWQvsQB8om3HsWOW7C8GkqUlGiEH7WPvyOZ34E7CdxEU7z4zOUC4L/znlsjhWVDUaLsz
         JxkBUT7xYKKXwhBcqzVYda35H+fV42RqxRVpIK9iBLPFLN+Pek2lKB07dWj8lsWM/jez
         Kqz9tR1oj2qXOU1g85b1p51lnUM1LyGuVLxAD/14FDCptHuQNFamwHKlatoE2xWEcprY
         NVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760841034; x=1761445834;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qAAYZ47bhgfxa75z5uHIphaVPwGXcOfi59M89qtfwjo=;
        b=HRhqN6/YclB0ZAxrepxK/5tRoCoFbcreea3GW04Bp128wktdOAbnmBrtVTThTxjQr4
         pX+TY83hk58/UPPm/knXqziVGj6fFyRJ/62o/5MsyufvE0EnFkC3/9e7yQSA5OoFJJ64
         gBiQjHlus9/6144YEQYu2CJh8X10VimIs/1SkPDa2EIaVgXQ+/+6X2Pswr1DHTQ+W+le
         9ObonGH7U2TyiIdau3dZ2lJfXTtWIi8Hwk2moBV1WtDRCXF5WpzqHLu1cjgBJp5bM0ee
         FDeQHLv4BZlbnZ+tZc6l9eug9l7MmprNdujoa71uHevw2+nCVZ3vrWgVYyPeDkAZTM2I
         DugQ==
X-Gm-Message-State: AOJu0YwNb/ZwGrNaIv6cw3XX6HozTJ+PDfMpI5hynyfbeqfTxzQRQKzF
	+WOzB7FWQy98lHUIEo4voPkNpGBX5ZRGr1gEGsOMSQOFiEMyCL/WAbM1ruHVmJeLCHE=
X-Gm-Gg: ASbGncvaAKLTUJ0foKZ6AKf+PpzPutRJSSjesqYflwU/wgQ3+nefMqJkbsmzpvnfTGD
	UhUo8/nF43VQQ+5tbDqbXmutDqX9dXVmus2W5RviSpCZzddFY20+zONpoZ4hFOmHJMGucKv7kbF
	VsPK2aEHnpIkEViocKkdKtNaslRdV8XaT5hw4ejNqWU636Yzuk3wRq/fOWjti7j/RzieU4LSfU9
	Y56B77Lmlo1xUFzpwOCEJtoUT7UMKxBWUbZ3FkV39KcPXXHv0Iq0EIrVNHijBiHAvb/MFxwmrG7
	yCM6h+LGYfI0Gc2RIUKD4sbADJORFeUV5zCl911qWkDCHQTbaWp4IRlZNoTZY3fVqMdbUGxAqSH
	Z5ZOPJAlu3Ar/EZ8678WUNg72nomcfRG0BHkr6q3hwei/tYeaOitkjGtaUS9bcppr6MPascZquQ
	2Hk7Ui
X-Google-Smtp-Source: AGHT+IGldJIycUqTQTLjA8rQ320tu1JA/3ETV/Y007M+sBup+qlNrrMSrL9+m3WVB/iZ48X/xm+5Eg==
X-Received: by 2002:a05:6a20:3d84:b0:2af:65aa:4eef with SMTP id adf61e73a8af0-334a8621973mr11439581637.47.1760841034221;
        Sat, 18 Oct 2025 19:30:34 -0700 (PDT)
Received: from 15dd6324cc71 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b67fa4sm3883831a12.33.2025.10.18.19.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 19:30:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable-rt/v6.1-rt - 50a28f95c66f40f394b6ac94b6552a16564b45ef
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: linux-rt-devel@lists.linux.dev
Reply-To: kernelci@lists.linux.dev
Date: Sun, 19 Oct 2025 02:30:33 -0000
Message-ID: <176084103312.3883.7273068958974556404@15dd6324cc71>





Hello,

Status summary for stable-rt/v6.1-rt

Dashboard:
https://d.kernelci.org/c/stable-rt/v6.1-rt/50a28f95c66f40f394b6ac94b6552a16564b45ef/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
branch: v6.1-rt
commit hash: 50a28f95c66f40f394b6ac94b6552a16564b45ef
origin: maestro
test start time: 2025-10-18 05:00:54.379000+00:00

Builds:	   21 ✅    0 ❌    0 ⚠️
Boots: 	   27 ✅    0 ❌    0 ⚠️
Tests: 	  861 ✅    0 ❌   84 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS
    
Hardware: meson-g12b-a311d-khadas-vim3
  > Config: defconfig+preempt_rt
    - Architecture/compiler: arm64/gcc-12
      - rt-tests.rt-migrate-test
      last run: https://d.kernelci.org/test/maestro:68f32e825621556c1f218da7
      history:  > ❌  > ✅  
            
      - rt-tests.rt-migrate-test.rt-migrate-test
      last run: https://d.kernelci.org/test/maestro:68f32f1c5621556c1f218e98
      history:  > ❌  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

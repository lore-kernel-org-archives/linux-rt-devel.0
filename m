Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A01E2222AA
	for <linux-rt-devel@lists.linux.dev>; Wed, 17 Sep 2025 02:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758076264; cv=none; b=R5mpQDkG90wPsZHBhohU05Mxn8vzERYTDtAfalPWmU4c9Y5UZ6L+9HspNCCZFFJpelRx8wVSpLvkJhKScCvcx28svJM3obckphb+UqW9cBhEGbWUGe3R2J0xwVRTwdl6dGKmeduNmglWNO0LJ3K80FMrHR31hXeVrYa26CrfuAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758076264; c=relaxed/simple;
	bh=+gi6Cv/7JSaKbxIT3DPt++ykIkyniCxcOaP8FVmIFMg=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=Yxal0kJYTWgvKe83t0jihYK7s1t2syueTlpbWc3OZWzn8Fqbo96PZ4BC3Ek6MlQJtrkaxsi4ZMUWGOPMOLiZxd/MecsGwsu/vXAdbOuaRP9apdCSScfLxvplHQPXJtiMDf7weU/668vx2PdD280zQAmY7bFmJG5IBYVgdoHuuEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=iTDqRCr5; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="iTDqRCr5"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77616dce48cso3479613b3a.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 16 Sep 2025 19:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1758076261; x=1758681061; darn=lists.linux.dev;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsocPekZwBnMMN30S+5APBuChlZRgYvhcSNeRM+WaAU=;
        b=iTDqRCr5WuPOgt8Vp4KmiA1KqRK8lwI0dNU2qMvUAOYCXYRRy5LtsKjwAUEQC3QZIw
         M/6LyrG3qworOKjt1mROrMEKp1eL1gLmBI8oXOFnP7Za7ji2zcSdcmmocaA/4bkqB5ID
         vga+gQVpX9ENjUjGB0wopjcjky+FjvC+y5oRBYYpjYF//l8brO6om9eHx/wa8qz30NBD
         tFDQULuJ+N3yr/z05sxl4xCD6nUuMA2ImqBMeYS5mZAqxDYpcaChVh/KglSN00OVWfJQ
         YEXtuMDCtDQCaST6T4Ugng5bMk+iq/44DdqkSvLp0QYgBNwr+RZFACPsBEmxOS9EyOZH
         ZRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758076261; x=1758681061;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fsocPekZwBnMMN30S+5APBuChlZRgYvhcSNeRM+WaAU=;
        b=XgxanwMSoP2VCspbtqmbg+IBafj+jFRshgALAmqIquUjBp02IU5Gwn8e3Lke4++jDu
         BkDDGo2xm22h741sWU7yH03AABZvX0wc1GPHxWf+ybgIErbROHcEVt7JwSDi8LDH03bp
         ZB/jFOkLlc2DrQIAV03WyEv5bUge1BnqIsQSHtHVFBvYZdVnl6e62IZrQLoymEs2inm1
         3V5F3nQVdBw6GzF36d7eoUnvMEbQRYrczsZ0cm0fObkpWvmpbHtgHvkEHuli1dZLU24d
         +heLYQdaFG7tp59xnxIB8EQbyHCLwSYHTaNQo4L3AnXZ41cC4EpcWq0lB94v0LXoZ6WX
         7a/w==
X-Gm-Message-State: AOJu0YyiKzhAF6XEYepu0e9rUUWdn/vZv7oOykM3rY4ioFj2LL2Mz30e
	jrQGZXOR4BWHJ27NqH/LINK9JU7GHQcdU7mvlY0s5Lh0S3QIe5RCU1h/U/JMBbxH64Ql3dlm6Xo
	Iu+jafBY=
X-Gm-Gg: ASbGnctDUdBUGATYW4012/olCzszTYkvXyx3HQXaIcy49I0EQ98Ibmm7XJOLWxN/hdo
	YSC6kdohFTGC5aoqa6KttSSXiGb+qjC9zHmaiiQcfZBD0DltK7mWCc8Rbc/qAqyzz+Lplob8K62
	iIr87pL3wVylogXZdiYzzOCHmi5gXrj7abxCmYwgEUEw9Im9WY6tvh5aIySxqw87OmeXP9nqu6z
	X8EAoioz6CDxAM7Wx+xui4bxUPDdK3gkSkDoepsnUhbxcLKin6yoICwLCIN7sOVZ/gDm+w0nuR6
	q+N+TqK0AXtmT1VboTv65kgzjZ32SyX/EEqnThlVQQ21zSrpfYIQ6gxcl+QFzfLvjfzLgOgw+Ns
	WQ9YNWrEeLw1gZvBE
X-Google-Smtp-Source: AGHT+IGJyeuysimjVT3ITzdKgqwsukj4MqiI9d6RNH9zITTQVMlFsRcTCrbBOTc7RjJX5c1sJ2mDPg==
X-Received: by 2002:a05:6a21:3393:b0:249:c440:9b39 with SMTP id adf61e73a8af0-27ab06e41d8mr629378637.54.1758076261357;
        Tue, 16 Sep 2025 19:31:01 -0700 (PDT)
Received: from 0383ca870dab ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-776224ddd9esm11328765b3a.21.2025.09.16.19.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 19:31:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable-rt/v5.10-rt -
 54256839470a39c368c97be0344d72f6f8749307
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: linux-rt-devel@lists.linux.dev
Reply-To: kernelci@lists.linux.dev
Date: Wed, 17 Sep 2025 02:30:58 -0000
Message-ID: <175807625818.125.493210195795825771@0383ca870dab>





Hello,

Status summary for stable-rt/v5.10-rt

Dashboard:
https://d.kernelci.org/c/stable-rt/v5.10-rt/54256839470a39c368c97be0344d72f6f8749307/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
branch: v5.10-rt
commit hash: 54256839470a39c368c97be0344d72f6f8749307
origin: maestro
test start time: 2025-09-16 15:59:08.481000+00:00

Builds:	   20 ✅    1 ❌    0 ⚠️
Boots: 	   21 ✅    6 ❌    1 ⚠️
Tests: 	  521 ✅    4 ❌   54 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: sun50i-h6-pine-h64
  > Config: defconfig+preempt_rt
    - Architecture/compiler: arm64/gcc-12
      - rt-tests.rt-migrate-test
      last run: https://d.kernelci.org/test/maestro:68c9925875b320799d27c60d
      history:  > ✅  > ❌  
            
      - rt-tests.rt-migrate-test.rt-migrate-test
      last run: https://d.kernelci.org/test/maestro:68c9ac2a75b320799d27ee7b
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: meson-g12b-a311d-khadas-vim3
  > Config: defconfig+preempt_rt
    - Architecture/compiler: arm64/gcc-12
      - rt-tests.rt-migrate-test
      last run: https://d.kernelci.org/test/maestro:68c9925275b320799d27c5f8
      history:  > ❌  > ✅  
            
      - rt-tests.rt-migrate-test.rt-migrate-test
      last run: https://d.kernelci.org/test/maestro:68c992f075b320799d27c76b
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

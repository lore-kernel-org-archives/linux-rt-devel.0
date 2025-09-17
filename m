Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A4D188734
	for <linux-rt-devel@lists.linux.dev>; Wed, 17 Sep 2025 02:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758076262; cv=none; b=L4XPpB30dlj2Y24kn2UdmUqls0TyhCSoXqSL2ubUE+DwsWXvCGu9Ua7iSrlNtGq1ps9u4I2yCzu4LPoYo7zeuKcm1YY6bxuufIAHI/vApTDOiPxqETM2V84oxnWh3pdwZke/0pMbKibaZ/jxKtaxAXgGlahmOg6UkeFaMmD4VUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758076262; c=relaxed/simple;
	bh=+gi6Cv/7JSaKbxIT3DPt++ykIkyniCxcOaP8FVmIFMg=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=d2R7vMI/CbqZwk8zqmui5TZ95GoFuNdjc1alWIAEvmzy1wvSP3QrTYs1w2li27bv/fB01tX/CLsJrMpZvKAdB9uHopslCI0BTRJ24uDYfGCMjWG+auZmD0/cS9Ss1gYcIqG681xL90lPLgh+Aszj9m+H7FTx2XsJvCo9eZlievk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=HF4n/Pju; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="HF4n/Pju"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77256e75eacso5012453b3a.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 16 Sep 2025 19:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1758076260; x=1758681060; darn=lists.linux.dev;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsocPekZwBnMMN30S+5APBuChlZRgYvhcSNeRM+WaAU=;
        b=HF4n/Pju3D67HpdQP11H0I4eqgyHB8nOvVo/TQyDJwfp4WsX8Irq1AfB+hRDhimXO7
         YAhWRnfks8LS6eE8xV+xGcXpBbuKDpfSh39DDcd/DTMk8aj5fryHbN+RJPw24J8ANbQt
         acMzsfZWnvf8B7DywDCwx7EaNTKxukUxxnslzo9Vuqx6N1oOnqM9bINMCPlBW6QmOIsk
         ZPbBf8jXK16Nq3AVN0eH6EBIxMguQoCCSqbZLpjCBiwddJO1TknzNeeVOFGRlrTEvyJy
         RzwlY0vg5YssPdugYAqzEVjeM0tWrULvfakeCUaTsusB16v6LcMtQtLP76bwDRCPuHrG
         lp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758076260; x=1758681060;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fsocPekZwBnMMN30S+5APBuChlZRgYvhcSNeRM+WaAU=;
        b=SvEFi8xVoliPaY91Bq6ObT5qhI0uHrnDrVu4FRyR7UVpqiDLZiErGybEZ94GgjXvk/
         XzAkbyZNI1TDCUfxhmhBTzni0hjwNQnCwcgx7I9xUKA9jRXxYu/pUNup7qdiIuH7LEB5
         lguczjirgQFCEVjPr8oGhw20O+Op/Ay6rz78kZmKlGu1o1ZnK0P6/3TJA7Vhb1oHDANM
         frad0c1D0YslC7bBPO9aP8zVmmyZZ1rcljJ9PX5TTxmHBON+XdaKBd9aXbVPf60v6Z1S
         08+v3kGeB9GjPcOlKJ6t0rptnKIEDflsmMu4y27q8g25lzkLxCURUpKeJn5n2b8YLxBa
         YtgA==
X-Gm-Message-State: AOJu0Ywt+QU7Xl8z3NUAstIZZp1uvSbaBmOPWtlm/C5uyUt2ttEAjbtr
	evNu/svQJ9BT/j1NMQmSqfI/rgsq7/b9nUPTT1a+4Mi6U4zAFsJqKV1oSOkGy9KHf4E=
X-Gm-Gg: ASbGncvowkk9tQ0pYTquCD5ItWbK09Vss4TfKMEMzTmL9/BhGmhFbDQxd73FTVtCHma
	JmOGTREesJmdJIQbguvYq/68WoCphiDuIwfmdGa1U4V3l2h1S3wPFMIKgh43T07wyEMKFqOoI28
	KfqKsYcCTipQvbLzf2zT+lP/ooJzAnXMNCCIZXtUn0qmZ3ZG4Vt2GbcX6vIkFTay7rOXiodyVui
	DxOX4nkERsgeqRU9jcnKX9/QUta1BIMKIGwdaqwZaDxoSOkOaflthCZRPTME76jrka1JjTjcARJ
	vohKAfxpmDunmtSAz7NQ5dH1gsef23cNIJCKgV5K3VTJCMxUIN7akZQMtpmmCXXZkNRwnGd5EL/
	L2ZnzY5mw7lz/YAkv
X-Google-Smtp-Source: AGHT+IFGYjQNjL8Q2Bp/4h13rlCz1Euv5x5QdccvihM2XaoBNez4yDm2m4Dl5YyCmL95uvNZbNVB+Q==
X-Received: by 2002:a05:6a21:3286:b0:25f:490b:2e8f with SMTP id adf61e73a8af0-27aad7f4170mr550261637.59.1758076259993;
        Tue, 16 Sep 2025 19:30:59 -0700 (PDT)
Received: from 325ff4dc0e06 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77618a7feefsm14030603b3a.58.2025.09.16.19.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 19:30:58 -0700 (PDT)
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
Message-ID: <175807625791.123.8599779965456759109@325ff4dc0e06>





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

Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F8434BA2C
	for <linux-rt-devel@lists.linux.dev>; Mon, 13 Oct 2025 02:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760322621; cv=none; b=Vei403p4aV54Cj/1RJB3JoWP0hqLvI8KJoEi+F6aE3UkBI6X1Pbqr8Uj/WGMGwBtPGv/ksa9+1d4HC6Da/i/A2TB6UHvMOiwdnpW5+ypwYkrJo1GV22s24RJ5tmv3CT7ZYAQOcHaa8TwOIDo0pQWWpR8gxERRZ/eg646owGAqdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760322621; c=relaxed/simple;
	bh=VpNvQh0MbXRkYbFT0rDDQ+ckk4FT9pDQkskjDfwvgfA=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=Oz2f0ftIc9RvPhuFVCqc0tXCK8ZdEx4t8rmv0b2cNjEEwwyYXUhrrwY4JKzCeUEpOtSk9o7U3yhVzI/j0kkHPTrxC/tsSIufiRVEoJy6wB1xsYnYB03jJrTvqeYpd74LG3y8dePGamJaMNJ3lBAQr3KlZ1RKaIYK/XohEm2fR1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=kWfK7tDj; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="kWfK7tDj"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-782bfd0a977so3168022b3a.3
        for <linux-rt-devel@lists.linux.dev>; Sun, 12 Oct 2025 19:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1760322619; x=1760927419; darn=lists.linux.dev;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OI+KqQiIpFHyXo+X/KiLIGPxHxuuG1JLeZpX2Ga+mt8=;
        b=kWfK7tDjvWSt14chDRAWQj4kS9bPpC+RxGSp2nw+lTnBIeZEx3vt/Q+byrJun+YC4p
         gWIFi+E0KRMn+1gDztaz65hBqNX75h4GqY/tt5602R1p6JsuU3bbuBO7XzgOg+kVRif4
         eXldyyKoOXqx2IkgsK5CBuG812bWXgLlTiARfP/iptbO+QmXflOTQtP4AINUSdkBcI6d
         SZ/7ZpcDvk82hDYtwNafWDaxv18AFTx54zk3C/9yU5Na4L2IWwQBAaxcgc8rfA/G6Y0v
         Jvj1ua7AHSZZsCQKk2ySG8zV5oz+FxX9AnhCtOoG9vo0Y+ofs61cTSw1ey63Vbs6SKB/
         D99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760322619; x=1760927419;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OI+KqQiIpFHyXo+X/KiLIGPxHxuuG1JLeZpX2Ga+mt8=;
        b=WmCnXrtlydH1rznCkDbAosIDJrKJ8ldiPOoEPAEuxCeUzvOocx0CcWQ15UTh2lyZ1u
         Y4Yv4PzAM+3LON4A3WdMYGZ4HQsqn3e9DuH6z5cf1lewSiPIagKdV+8jcVs7Uf09EATE
         fWIAN4SdkygORrR2A1aQCiqMyCNFJgeGymI/w022x8RxUkHWjmgcYtOjVldXcD2swyk7
         Jeixrs3cmDFUHvPhVtP49LUSJteIsnrw31yo1/WdNS88IOzmr6Mdi9IXGCp47LDXCo/Y
         M278dq3iYFIfr8lSsmFSf7Shf+avoD70Gz7QPQHZBJgK7Pk8kNaVug5sQaBW7Y3DpUnm
         louQ==
X-Gm-Message-State: AOJu0YwZnzOkU+4zezOFOrbFD/BoN50vC7kuOGRTd5ehupif24UUCIlM
	hQKu71bdB6zbo2zEE2KEPOU8gdBEXMC0uSMRpjFzO+HACEKXV6qrMqj0cHo7BmQw2LvU38Y0mV/
	EU4Ua
X-Gm-Gg: ASbGncsD80iFpGx6znNh4iMbgLxUTfnL9EThV8+gpRynxGFZjMVaV+JW7AgCNN1qO02
	p/ltsXxWu+a6fgj3vUMvd9MQHq7e2zASNxgzesIRXDDLPacDq3SGVAH4djCmZhOhVF2yid8L4Rk
	h1fTcEev3oBnTvnrTA5YiJ+z3DBL2mOBc8SliTkkgUEPqxUy752bdlBzGGzvykQwATObiiUQH3E
	sjYWe2SWy/6eUmiLaGI8Ky19hAwwdaLQBdLg3EG/T9QRPaJESBzioGlidd2a569gs4HcdtDsHMD
	BnPojfbYGVrwhRrwpYNc6382utBZxwQdgMtkMeOi9Otpa2QeXyI2BbrhuO+M5kYq5HQdEit+lUq
	gb0Q4dmB9wN18d714P9vhVDn0+SNGDejRcGt/Xyhq722Nb1kdehR9KaOU
X-Google-Smtp-Source: AGHT+IE4UTbKgQt5JcKia7Ju6Fqlu79/7EjQIK6jhbCosr3vFxlMYAFxZhUFJzUMz+e7YA8YS5Nhjg==
X-Received: by 2002:a05:6a20:2589:b0:32d:9131:98aa with SMTP id adf61e73a8af0-32da814a16bmr26877367637.24.1760322618966;
        Sun, 12 Oct 2025 19:30:18 -0700 (PDT)
Received: from 15dd6324cc71 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b0604cfsm9915781b3a.9.2025.10.12.19.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 19:30:18 -0700 (PDT)
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
Date: Mon, 13 Oct 2025 02:30:18 -0000
Message-ID: <176032261777.1102.1303238923285430954@15dd6324cc71>





Hello,

Status summary for stable-rt/v5.10-rt

Dashboard:
https://d.kernelci.org/c/stable-rt/v5.10-rt/7a9ef2cebfadb557a32d8fed925475de07f9ef86/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
branch: v5.10-rt
commit hash: 7a9ef2cebfadb557a32d8fed925475de07f9ef86
origin: maestro
test start time: 2025-10-12 18:09:08.356000+00:00

Builds:	   36 ✅    4 ❌    0 ⚠️
Boots: 	   44 ✅   11 ❌    2 ⚠️
Tests: 	 1386 ✅   88 ❌  186 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: meson-g12b-a311d-khadas-vim3
  > Config: defconfig+preempt_rt
    - Architecture/compiler: arm64/gcc-12
      - rt-tests.rt-migrate-test
      last run: https://d.kernelci.org/test/maestro:68ec056b9512ca52745b5540
      history:  > ✅  > ❌  
            
      - rt-tests.rt-migrate-test.rt-migrate-test
      last run: https://d.kernelci.org/test/maestro:68ec06149512ca52745b5bee
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS

  No unstable tests observed.



This branch has 2 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A1540DFBE
	for <linux-rt-devel@lists.linux.dev>; Sat,  2 May 2026 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777689023; cv=none; b=QvL9OXxcakYQWs0tbg5Oolvj+A16rBjXSbqGa/EcYn5nFEdo28D4CIyuiiPfv6DEXwezSqBR0r3Xm1XrahsiYZIoiL5KeyekCu9rq/XXnUHKBdST/5btZSZSFdNj/ginhZt0NYgPE5wTPA3/8td/dUkYbJk7KOob7Y4vssQ2MAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777689023; c=relaxed/simple;
	bh=qG8lpWIre0McORc5Vxa1u1oIKxBi0coqdI0hPrTriGA=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=g6IyINIWFRx5gj3mNpqQfQUoEXc3IaSD3IaF9lCn4Ndbg2UguQjVpu2T7nrcCZKPfxSq98t9d4jnvZ6kDTo8MDo6f4G/jbJ/nzkjSXLGdlHqfJsQ+yZ31vQsHb6e1JCJDFuxhq2xn0rkYSQbrTYXXxm56c17V3EkzFe1OwS3dVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=jLAOBAd2; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="jLAOBAd2"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ef38cf04f0so1493263eec.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 01 May 2026 19:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1777689021; x=1778293821; darn=lists.linux.dev;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7N1zN0rrOZxx1IKvgEmcsOcPKgtqPMchAdymwe4mi68=;
        b=jLAOBAd2QfgnwHcN5f3ruTQdAxHYpIg7cHaUN+VrYluzcWJnoqjxIdWRpcp3W1vZUr
         wmIC3hDsopLl3FHV/lxPv9uowexeOofvPxvNYJ64FrnQ0eR0xEhx9wAELwpXh0RoWWEz
         /p89COPQjqd44i9Y2X76QdXo1woII9RMXlnNmzcgcLpNxAVbWanS/mSSpXnp+/oeAedt
         gQDFJv4MrPMZtorh2yUwHIDv3oqcFp6tcnI3xOhCIXo+1CKcSVO0pGOTfBpcHruj4wj8
         rfff8vtdN3S3XdQjEcz02F1STJJ+gGraaL6o0nLLftGb/2aUsbB87f0w/IycpbQPThv1
         QRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777689021; x=1778293821;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7N1zN0rrOZxx1IKvgEmcsOcPKgtqPMchAdymwe4mi68=;
        b=hv7LnC8AfOGNLKCyVFguGsIj7b3e0ImVHFiRwGvjco6i/9N5l99ZLNeewLnTD+cT4d
         DgnksAn8CVj+JLalReklonQ1psPtcmx5ZjoFqDqqjbLzxyPbaTLlH0BTdK9lYuxW8++u
         fuuwbv78zbANeoD7QcPVvqJOr43NzDgOj/9NqKVJqbDfZcabEWo/pwPDEYehV0raqSOe
         IgXokJ2LTe6lkhtsfpY6yFnol+eWf42VRSW2tOsqwDMwVgajtCesu/nMuxd6jR5IsyMg
         D/dgU/YjEE/xM+zvfVJisx6vklopela0ZCtEsZvLORg+zfxm/Fbz4Ta/EEC8WudGeaxq
         WTwg==
X-Gm-Message-State: AOJu0Yx9/9TxRFLq+B9w8yhC9TzPRZlVlAorapLIsuy8W0K/BBpgC5QT
	p4J90BRK+UaUNVPAn+XNz56/auUqovHpCBCqn5kBc9sFb1JdahMGJWFgP4j8AfiyqGjkhd/Bamu
	ry/5y
X-Gm-Gg: AeBDieu2nzncFmha7/tv+tmAgz1KtkSZuRDfirJvFXR/GTCxP0smHm0Xr/R4x54Z7f4
	gVpmIGEypvAmo4BT57W6lOV/rOVd1q1/5rdca+s4rQyoC0mV/ZDoNA8dVEz7Nj3Y0YMAQsdV+80
	8we7edVI6V5ELnp1U8UUnmT6oskAfRfEd6pHc54XM8KcRS90SOMr5RRbZ5Su7IgYLcI5yBghN9U
	QhC84m5cSUw+4oUsqGBgLra0dgh+AkYl17pKYoT5p8ePetBfqoeFiHFixGHqU5CExgSyU+yG6EA
	uh3FGgeCF+IQsCBgPlIlyd03cVhIt1UFmsxFN/IxYOloT6zPzOCZ2Sh8tGSAjE/0ihLCniCKvzA
	Xww2NFQbLrSumT2P841sPb/33de2xwuu3Ls4e/qTjy641EJAfJiabmer/NsZa0pz6He9YSNT8xz
	VatlVY4UugPK74vL6qnwzVqim+XfY=
X-Received: by 2002:a05:693c:3b05:b0:2ed:7e1:975 with SMTP id 5a478bee46e88-2efb7dcafdamr816573eec.1.1777689020588;
        Fri, 01 May 2026 19:30:20 -0700 (PDT)
Received: from 997d03828cfd ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889d611sm8737318eec.1.2026.05.01.19.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 19:30:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable-rt/v5.10-rt-next -
 f5f9db4f1f46003faa3cae7887694a2fd5afd288
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: linux-rt-devel@lists.linux.dev
Reply-To: kernelci@lists.linux.dev
Date: Sat, 02 May 2026 02:30:19 -0000
Message-ID: <177768901960.1231.10189288126960728153@997d03828cfd>





Hello,

Status summary for stable-rt/v5.10-rt-next

Dashboard:
https://d.kernelci.org/c/stable-rt/v5.10-rt-next/f5f9db4f1f46003faa3cae7887694a2fd5afd288/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
branch: v5.10-rt-next
commit hash: f5f9db4f1f46003faa3cae7887694a2fd5afd288
origin: maestro
test start time: 2026-04-30 22:15:16.011000+00:00

Builds:	   18 ✅    1 ❌    0 ⚠️
Boots: 	   26 ✅    0 ❌    0 ⚠️
Tests: 	  688 ✅    6 ❌   34 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS
    
Hardware: rk3399-rock-pi-4b
  > Config: defconfig+preempt_rt
    - Architecture/compiler: arm64/gcc-14
      - rt-tests.rt-migrate-test
      last run: https://d.kernelci.org/test/maestro:69f3db818bc8b7207a7a40ec
      history:  > ❌  > ✅  
            
      - rt-tests.rt-migrate-test.rt-migrate-test
      last run: https://d.kernelci.org/test/maestro:69f3de608bc8b7207a7a446d
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

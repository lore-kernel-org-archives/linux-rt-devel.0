Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59355139B
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Jun 2025 04:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748926594; cv=none; b=jbq+CmXyOCgr00a+4FZZhlsxK29eNqx+IeY0kBh9UrjYsGKjVj3Ebi9auj2TSO/vRnUaRzuX9fiQLThyledueYeOba8MPkuxH4H35HeoybFh/I/rcxRnO8083WtQ3RS/hWIccHTwP6yeocnT+zlnkN7ulmiaML3UdmRULMeArjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748926594; c=relaxed/simple;
	bh=oYMqfULeZPGoKCGddcD1RK8vhILr9q8b53wOjmMVyoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMNm5yjAjzhU4MFYOw3yQOeDBd9svjP6hAP0b9dlZmqi7zf5DbTx9axGJO0PkempIodjq6xckDNJPYhdJk+uukA80GitrN9kqtAHPNwJAg1Xw0Y2zr/baHtDD6qN04uf/XrpgvTUGAxINfcnzX1UzHw7urTrZ+O7h+QeB1PdkvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7cscMV9; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7cscMV9"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-747fc7506d4so361313b3a.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 02 Jun 2025 21:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748926591; x=1749531391; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bj5cAM1/rmK0n2hEMe5+To8Y8SpxiSCSEVLQ6lLbhIk=;
        b=T7cscMV9JzoyaF4js5x9SBvmXw51CPyJO8Qx0N2KKZPOxVMJOijmYblO5KDeKE6DcS
         YMCtbCTNePOl5BHoFnCRAeBL0eJFg/C4++S8l4KsF04M+CUqyOVHyZ+umAQCEXCB6M+f
         toy7lR8ar+TCk7nvD0g/hA4puEzWaNKRRMcmkoLy9DArXr+W1QVEkYzoiu+5dhhrRy0i
         IqHppNWDTGzpEbrECqW+7O/mJ6K/3kosN6ZTNkP9fj2a5+44Fwbwya6MZZZnxd4bNk5O
         D6fu9Jd+bvpkWrniHzzFqux9XBNQwf7+GGWqfl9OdlOQdrhhgLbHtIYxTyKLSiFUoijD
         XFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748926591; x=1749531391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bj5cAM1/rmK0n2hEMe5+To8Y8SpxiSCSEVLQ6lLbhIk=;
        b=VbVRZttoG3iMuv+KPq9ngjkTXkWOZ7Di3ZgkBcrhVWXLuLwDKJQQf8wyQwSstXbBIc
         H4lVJMNcDF/KpoYeoQAr9EcUnUmtodEm5WXG3qdw1St716wEnNBDTGG3IfUhwsQQ8FZH
         sMsEsBLI+LO0a3AeycG22GOnSfcPmTw4xI1cZYAM6DtaMm8Fjfk4L71GMvHbYeYAubwd
         EGDoH94576J/d4Au25URDpN7u/aKhCs7p0mg8FXC5L0ZrLLFf0Wuo5BWXxW0k5qUdway
         s2JiaQOxVqykC842BipZnAruOj3C7zjV8Wx2yc0WY36rel/Fm31tAwDWyh/uETB9dK60
         qssw==
X-Forwarded-Encrypted: i=1; AJvYcCWSrnG51+1PTMr50YsV7I5ozqseWtLzzj9pnt3LoU06tRJ7nopw8tDZL5G5yGk06sr2Ladk2J38F+GCwqMwXA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUeNP3I9La+PcdcLuTpSTEmhaG99/9ijZ6akH9Rxml+mkwafrP
	pf2reWJvg7YhPTaR6lTtMjwrZDKGFwpDe2TuQWaiGZbtQ0mDvl8aOWCq
X-Gm-Gg: ASbGnctM05G7nMivurR0TGZsts2uc45Rku5PFPO1Nxkajw52Q6MyjbgrdXr5jpgTooU
	exm2qSwZl1dBgGAwmlcj8fPW4aYoJirxthdC1Y7tx+PmMeLsl8QcCHv4mn9iSsSand4y4CSH5KU
	3RfQgr2GKGhlWn5uhxLBHhi/Nzmb/P5ASq/nRvDAdaxya4PGNsNTyFqrydl1XP8+sl7AmaQorAJ
	RIx21VQsNszkhFuXXkOZt/xKv81k3Bu9ZaBOlIplsx32hX/cvuc7CYREb2KYx1lJEJtpyRTiY/A
	RUZL/CVD8EEjUVV8qadOsFf1Z34cVqCD3tFSBkUdblMD7ETOpKkHans9nh9zLMB3
X-Google-Smtp-Source: AGHT+IHJ9xKtdl5zDj/gyXRWXE1LClYzP6+346qAd6s0tgh3W5JiHGwy+E7+vAoDxPugtmCWu5XIdA==
X-Received: by 2002:a05:6a20:7349:b0:1f5:95a7:8159 with SMTP id adf61e73a8af0-21ba1165cb7mr17413574637.10.1748926591543;
        Mon, 02 Jun 2025 21:56:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afff7464sm8549267b3a.180.2025.06.02.21.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 21:56:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 2 Jun 2025 21:56:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: [v2 PATCH 1/9] crypto: lib/sha256 - Add helpers for block-based
 shash (RT build failure)
Message-ID: <85984439-5659-4515-a2bb-09cdad69a3e3@roeck-us.net>
References: <cover.1746162259.git.herbert@gondor.apana.org.au>
 <c9e5c4beaad9c5876dc0f4ab15e16f020b992d9d.1746162259.git.herbert@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9e5c4beaad9c5876dc0f4ab15e16f020b992d9d.1746162259.git.herbert@gondor.apana.org.au>

Hi,

On Fri, May 02, 2025 at 01:30:53PM +0800, Herbert Xu wrote:
> Add an internal sha256_finup helper and move the finalisation code
> from __sha256_final into it.
> 
> Also add sha256_choose_blocks and CRYPTO_ARCH_HAVE_LIB_SHA256_SIMD
> so that the Crypto API can use the SIMD block function unconditionally.
> The Crypto API must not be used in hard IRQs and there is no reason
> to have a fallback path for hardirqs.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

This patch triggers the following build error. It is seen when
trying to build loongson3_defconfig + CONFIG_PREEMPT_RT.

Error log:
In file included from /opt/buildbot/slave/qemu-loongarch-rt/build/include/asm-generic/simd.h:6,
                 from ./arch/loongarch/include/generated/asm/simd.h:1,
                 from /opt/buildbot/slave/qemu-loongarch-rt/build/include/crypto/internal/simd.h:9,
                 from /opt/buildbot/slave/qemu-loongarch-rt/build/include/crypto/internal/sha2.h:6,
                 from /opt/buildbot/slave/qemu-loongarch-rt/build/lib/crypto/sha256.c:15:
/opt/buildbot/slave/qemu-loongarch-rt/build/include/asm-generic/simd.h: In function 'may_use_simd':
/opt/buildbot/slave/qemu-loongarch-rt/build/include/linux/preempt.h:111:34: error: 'current' undeclared (first use in this function)
  111 | # define softirq_count()        (current->softirq_disable_cnt & SOFTIRQ_MASK)
      |                                  ^~~~~~~

While the problem is only exposed by this patch, it does not seem to be
straightforward to fix: preempt.h does not directly include asm/current.h,
and doing so only exposes follow-up build failures.

Reverting this patch after also reverting the follow-up patch touching
sha256.c fixes the problem.

Copying scheduler and realtime subsystem maintainers for advice.

Guenter

---
bisect log:

# bad: [cd2e103d57e5615f9bb027d772f93b9efd567224] Merge tag 'hardening-v6.16-rc1-fix1-take2' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
# good: [0ff41df1cb268fc69e703a08a57ee14ae967d0ca] Linux 6.15
git bisect start 'HEAD' 'v6.15'
# bad: [b08494a8f7416e5f09907318c5460ad6f6e2a548] Merge tag 'drm-next-2025-05-28' of https://gitlab.freedesktop.org/drm/kernel
git bisect bad b08494a8f7416e5f09907318c5460ad6f6e2a548
# bad: [a9e6060bb2a6cae6d43a98ec0794844ad01273d3] Merge tag 'sound-6.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect bad a9e6060bb2a6cae6d43a98ec0794844ad01273d3
# bad: [3349ada3cffdbe4579872a004360daa31938f683] Merge tag 'powerpc-6.16-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
git bisect bad 3349ada3cffdbe4579872a004360daa31938f683
# good: [8fdabcd9c01d9ac585d8109a921e0734a69479fb] Merge tag 'gfs2-for-6.16' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2
git bisect good 8fdabcd9c01d9ac585d8109a921e0734a69479fb
# bad: [2297554f01df6d3d4e98a3915c183ce3e491740a] x86/fpu: Fix irq_fpu_usable() to return false during CPU onlining
git bisect bad 2297554f01df6d3d4e98a3915c183ce3e491740a
# good: [0d474be2676d9262afd0cf6a416e96b9277139a7] crypto: sha3-generic - Use API partial block handling
git bisect good 0d474be2676d9262afd0cf6a416e96b9277139a7
# good: [7db55726450af0373b128e944f263b848eaa7dc2] crypto: qat - expose configuration functions
git bisect good 7db55726450af0373b128e944f263b848eaa7dc2
# bad: [bde393057bbc452731a521bafa7441932da5f564] crypto: null - merge CRYPTO_NULL2 into CRYPTO_NULL
git bisect bad bde393057bbc452731a521bafa7441932da5f564
# bad: [ecd71c95a60e7298acfabe81189439f350bd0e18] crypto: zynqmp-sha - Fix partial block implementation
git bisect bad ecd71c95a60e7298acfabe81189439f350bd0e18
# bad: [5b90a779bc547939421bfeb333e470658ba94fb6] crypto: lib/sha256 - Add helpers for block-based shash
git bisect bad 5b90a779bc547939421bfeb333e470658ba94fb6
# good: [165ef524bbeb71ccd470e70a4e63f813fa71e7cd] dt-bindings: rng: rockchip,rk3588-rng: add rk3576-rng compatible
git bisect good 165ef524bbeb71ccd470e70a4e63f813fa71e7cd
# good: [8fd17374be8f220c26bec2b482cabf51ebbaed80] crypto: api - Rename CRYPTO_ALG_REQ_CHAIN to CRYPTO_ALG_REQ_VIRT
git bisect good 8fd17374be8f220c26bec2b482cabf51ebbaed80
# good: [7d2461c7616743d62be0df8f9a5f4a6de29f119a] crypto: sun8i-ce-hash - use pm_runtime_resume_and_get()
git bisect good 7d2461c7616743d62be0df8f9a5f4a6de29f119a
# first bad commit: [5b90a779bc547939421bfeb333e470658ba94fb6] crypto: lib/sha256 - Add helpers for block-based shash

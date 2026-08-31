Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB8637646E
	for <linux-rt-devel@lists.linux.dev>; Mon, 31 Aug 2026 06:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158034; cv=none; b=B+EmqvfvS0VV9tzDcX6FvVaARMc19RHoTTWxgj1y8OdHRdPKPkjKQuq5ErRjCUlNKZ8umPNYyMOYpErzOnTVPeUP7Yoe1Q3zUrTO+6J8WC7d5pFvKBnoOnszQLNB4Lgn1RQ9yln0KnECTjhbv3An/jsBQgXnSD94RhqOfJJIc08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158034; c=relaxed/simple;
	bh=4r4B989XhNn5855KWt3NM6Au1pnhG8E2OSje25w3ack=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmpZvj3wfX+f4lxXQqrrLPnfku5rFw0dxm3Z1ojyTnfHoSDUYkat3ATLQl03yi9oTSXew8jXV8JsdRi6H0NNUUblVkzQdI+UsYWnvG1afT5U7hNZCwydYzPUCHQdnHJ0F+Pf1oPBeMriqVzs34f1281t1XHixHbN/LvG73BWNO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F31/8ntb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F31/8ntb"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d58efc7356so35929085ad.1
        for <linux-rt-devel@lists.linux.dev>; Sun, 30 Aug 2026 23:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788158032; x=1788762832; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZdYVDo7588sL82RPlR1GkDzeflr+52xwAeMcbvupztY=;
        b=F31/8ntb02IA6vXEv07KN/0yXcaV1eC42Ul8rVb8n0MTLC1J0Rd5XReAch39llqtJ0
         VPd6SXlkzreTZYwer5KWzcCzhA8Fp1uNqp1m2MV3zXpSaEupTiFqvTj4GlbLCPhSvMSC
         En7GNUQF18+4QrbbGRHE7e+NpIVO0bQDU/bRmkm/kqmBgUFeslmDu0aJADio3boGagXi
         7xvWz0ku1w3FxiIRoy8QeR99xP5JDln4ogkrh55BaZLjl/v+2TT855SZzpGBKZ1qo9DB
         KWhU8DcDMOJTLZXQ0aQ7Xho42BOoNBKGfDeEWmHMVPtHHGWjKieDbYBhWeFv4m6duTNn
         wTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788158032; x=1788762832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZdYVDo7588sL82RPlR1GkDzeflr+52xwAeMcbvupztY=;
        b=PIsMyGGl5li7jYSJLs2ErFBNuHrmmN7bkhsH8lxwxxdtM3P4AD3WQs2cfGesse26Rn
         KbRPaskpShSpCeVRDpKDnvtaesfo57bE2ciu0gD08Gb1/s4xN+AG5e0p7M07do5OuLSZ
         4boHptRrPOJzFxa2XgLi4SXBH4/lVAvg5Dt1NTMQhUk/QhLqcirQ0vtkhz9Dhf4TcJbb
         csUgH4nXgXtin6c2pnFe31y5VGINwmfvdoEQzjOAR6It61SbemB2fNvZOrI4DSBk/dsd
         tw6aroBSWHKjtOlFcX1oWF1K3jtC2eYGuqsRQxW5jgzVa4G11eI8TlK1yszYwDJYpCAg
         XaGg==
X-Gm-Message-State: AFuF++kbvzwEGx6hsjdvHFCR8LW3fkpLLirhsZYPsG/riOVSIpkOQWpE
	eGF3Rr0db0buX3Zu9Mi+kYg4beXVWDOHNHXjOg/9PjhzM147XkaEaYHeJTgDYg==
X-Gm-Gg: AYBFou3DKvOu1TCZXw6J7Vs3h6Ive8aNqJ/OMTLb5+cB+hSpslzE1L9dSnnJ/W/jGL8
	AhwEN8Gbt5yjT37EUYDMwaoXV4e6k2pmGAxk5FkwGHn89nK+7VgrFbJIh4t12DRpsge6g3cZyyk
	YCtpgGnABZ3zwj4OKCxtZIegCAxu6OP8cLbmJ3moHNCLLFyqbKh0mY4Kdc6/YXEf2WMi6Jb63Iq
	PgiQ29ob8FT2fd2T95tCjV4hP2ABbfbizKFlYYyvRTQKbPhXkcrR5YiIS5CH+xAMWYbFapIDmO0
	f+NycNI3mU4Pe2dTbojhdZ1uY3z9brtva/ypyGBJ4RmLDWN2lrerEToOsrMKN4GnsEARenQanFz
	rOgN+pNqQr8YmkdY9woG0+Y9TmtgKR6srGxOCNvTDKPkPFE6hXAxCEsatiPIh/281DrrUrKKv7E
	btWHgNVATTY7ao4MvgPKGp8Srl6YD8JIpp2tnEDivgEa/SGP1aK9v/5lnSKl+2C06u+5cTonBI4
	5lzM4Q=
X-Received: by 2002:a17:903:286:b0:2c8:248a:5dbb with SMTP id d9443c01a7336-2d74dcbe867mr391007535ad.7.1788158030880;
        Sun, 30 Aug 2026 23:33:50 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:21dc:72d0:e0c:d445:c26f:9091])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75963bc14sm29404725ad.32.2026.08.30.23.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 23:33:50 -0700 (PDT)
From: ThangNN99 <ngocthang2710.1999@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev,
	linux-mm@kvack.org,
	Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>
Subject: Re: [PATCH v2] mm/slab: don't use kfree_rcu sheaves on PREEMPT_RT in kvfree_call_rcu()
Date: Mon, 31 Aug 2026 13:33:44 +0700
Message-ID: <20260831063344.7933-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831062054.319EA1F000E9@smtp.kernel.org>
References: <20260831062054.319EA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks, both flagged items are pre-existing and out of scope for this
patch:

- The headless kvfree_rcu(ptr) might_sleep()/synchronize_rcu() path is
  never reached by the caller this patch fixes: set_cpus_allowed_force()
  uses the headed two-argument kfree_rcu(ptr, rcu) form specifically to
  avoid it (see its own comment), so it's unrelated to the sheaf-bypass
  this patch adds.

- kfree_call_rcu_nolock() still hitting local_trylock(&s->cpu_sheaves->lock)
  unconditionally is exactly what this patch's commit message already
  calls out as unsafe under a raw spinlock. This patch intentionally
  leaves kfree_call_rcu_nolock() untouched; fixing its 'any context'
  guarantee belongs in a separate patch.

This patch stays scoped to the specific syzbot-reported splat in
kvfree_call_rcu(). Happy to look at the two pre-existing issues
separately if a maintainer wants a follow-up patch for either.

Thanks,
ThangNN99

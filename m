Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B911E3AE19B
	for <linux-rt-devel@lists.linux.dev>; Mon, 15 Jun 2026 20:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553718; cv=none; b=tscWhwY4xnym22EyuvuNFkDj6AwBlEm//5ipHrVfLtum2LTRamGWU0i/JKbd5ZmxmYpVNHnBgpvqArQCueafh72F8wvpwmwYD05px1J3cWh5yEiMqoLyEJJHA9tDBhDdPSjIJ7/5BMLn2sXvQMS1FylpI1xzl/45e4OcyvFqFNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553718; c=relaxed/simple;
	bh=t8wGM2SNC1ZbIykMA3lZWDIYfskaWmiv8ePp9cK/vJI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=utrl9XEhz352DS6jEAkMFRyavQ8NAo25lslq7Dr1EX1KKjs3uiPLxKXYJkTxLbebg9tqJ4MK4tSo5/gjPSXCdiIFgX09PVHsw3bRGPWeTmvOcqvIibABSh0JQwpdyxTxrntW7mFKRCRCkqXiYzl7Wz+u7nVes2pggBuvE75dAJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhIrpgNr; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhIrpgNr"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e6e2d54d3dso2125480a34.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 15 Jun 2026 13:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781553717; x=1782158517; darn=lists.linux.dev;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8wGM2SNC1ZbIykMA3lZWDIYfskaWmiv8ePp9cK/vJI=;
        b=KhIrpgNrkF/fpuhO1+bH0X9OXtgvmq3gb0C6dFWVK4dHBeJ31od0CHyoMHfsLDIfSh
         DaYj9D2KYaj72FEXKgzjjDreFnQWwSbgjn3cz3plC8zfdMdRNXiMxzqvC7jYDBKI+R/q
         RlkXQOotB1uUi74t/9t17eWIDEtb6wqfU0N2+pSJcciDY+Hprr9UrB44hMAlShNMZ9rW
         ljQeYwgnPJuSUzQ0A6zf+KzwaORPuMHlVfUg0OZZPQ86jtgiK5qgd4NsNao3r/SzU7CR
         nkHdeVoekdzIle5LmHyxYGevUTvfvQOa4/DV55Gu6W1zo06KruB8jj7NSVIizMlrktH7
         blpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781553717; x=1782158517;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t8wGM2SNC1ZbIykMA3lZWDIYfskaWmiv8ePp9cK/vJI=;
        b=G1IqY+l/1EJHbU5iW2TFrsZ2CusWxmg/QOMrxQoALaDX24n75FszTJpZdzDqGu74Cy
         2SYyQwPLSkopSGICW5gv2IMRGfQL4ueykNe9vpmYuoSxSlJawTI5Ysc63ffXlWhPeD5i
         HCW21NV9tvLRodqsmDObkWWIy3hlGBJFNp1vmvmuSnMx+ZnQ2dbeyUmxnNxHoKvoDrg9
         yJKVV46RhhZnHK3obsdljrap2onA4F4/IBzZDK9zyieCufuQ/Zt0+sU0cnbilP8xA3Uf
         KRPsPRKrqsHYCBpYGLYcQF+YmSwQ/5YQm5OsR04vpDWZYNWXmmtAhNjIO4TrdaOgf4Tr
         Limw==
X-Forwarded-Encrypted: i=1; AFNElJ+rwRqd9p/DB7ST06500uuJs79TWWFbVZ3uHm/QXpyA5AlaUZLCOLUgEjIGd3J79DYsMjbAqB1PrOu4me6d7A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZezNlvJTvj01RR693cwCgl8dvNh7/s7cGKWzzpCeaKU1Lp4ee
	Y0Q4jUCCXdLJRsZFD38nvUtEq1NaGuHXGFQYuu+rFDE1K8Qbqx+ejIUW
X-Gm-Gg: Acq92OGRAKsWHL76P+r2QLenb8kDfrwN2yAigtG5veJRQwm2YOIDCugIb53FGdzFAUq
	Sv5e4NQ8is/UHOfnTM7BVg3ISyKf7enJGBq1kjzQKtzD+C21RHFprsGKtzF8wEDPe5OJWTkZG7+
	eRatLec5FVPt/lQ/+mSb8ARmFLdnoK0QwuRxK7mLQVw1po5mnqRHLHearjYLbS7CP5kaZP4NVPJ
	2qf0pes2ITbBNffFy3q5LycC2CqCTjFvign+rYTG/UT/Lwdv0lvHP5t6kBRnti/aChqNHKiIpQv
	V+Z+ZR9NHAPCcNiznm1t/BazcS38vCWxUexR3yjjSdUFDzYPGhSiVR4ijC0Pk9keCkWxQ4y8gTy
	kZI9Uj35yuciAVOHuDyJ1h2Eblz8viQ/BBi6yzyhAw5f8l5F89jIO5MiSTjWy2PI1c0dwBhUPwq
	7FvJVsb+/9Qf5STbYgdVtga5B8+b3aGCTk5CyOXGx770siFNXjTUdFLXCrUMA/fmqIElD88yk9X
	c0F7DOg2s5PedodDhtrxo44X/w=
X-Received: by 2002:a05:6830:d11:b0:7e6:d542:aa with SMTP id 46e09a7af769-7e8fc512f82mr716552a34.23.1781553716566;
        Mon, 15 Jun 2026 13:01:56 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f6b8624sm4773335a34.16.2026.06.15.13.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 13:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 13:01:54 -0700
Message-Id: <DJ9W31UCKPW5.R2LKIC72ZQ68@gmail.com>
To: "Harry Yoo (Oracle)" <harry@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Hao Li"
 <hao.li@linux.dev>, "Christoph Lameter" <cl@gentwo.org>, "David Rientjes"
 <rientjes@google.com>, "Roman Gushchin" <roman.gushchin@linux.dev>, "Alexei
 Starovoitov" <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Puranjay Mohan" <puranjay@kernel.org>, "Amery Hung" <ameryhung@gmail.com>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, "Josh Triplett"
 <josh@joshtriplett.org>, "Boqun Feng" <boqun@kernel.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Zqiang" <qiang.zhang@linux.dev>, "Pedro Falcato" <pfalcato@suse.de>,
 "Suren Baghdasaryan" <surenb@google.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>, <rcu@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH for-next v3 1/9] slub_kunit: fall back to SW perf events
 when HW PMU is not available
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-1-70a54f3775bb@kernel.org>
In-Reply-To: <20260615-kfree_rcu_nolock-v3-1-70a54f3775bb@kernel.org>

On Mon Jun 15, 2026 at 4:05 AM PDT, Harry Yoo (Oracle) wrote:
> slub_kunit uses hardware perf events to invoke _nolock() APIs from NMI
> context. However, creating a HW perf event fails when there is no
> hardware PMU, or when running in a virtualized environment without a
> virtual PMU configured.
>
> Since tests are often performed in virtualized environments, fall back
> to a SW perf event so that the test can still run, even if it cannot
> cover IRQ-disabled sections.

Frankly, I wouldn't bother with this fallback, since it completely misses
irq disabled section which is the one to test with *_nolock().
VMs need to configured properly. Even nested VMs support
PERF_COUNT_HW_CPU_CYCLES.

Also in overflow_handler_test_nolock()
I would add
even->hw.interrupts =3D 0;
to the end to make sure it actually stress tests things.
Without it NMIs are not firing quickly enough.


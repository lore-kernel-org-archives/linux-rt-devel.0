Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285AE3B47C9
	for <linux-rt-devel@lists.linux.dev>; Mon, 15 Jun 2026 20:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553889; cv=none; b=DmZ9ZmBDFzaAChymwOqv6eejv8OABN6pObwW+a6sBC3E1cpBIJVZZUOzE1m6lKnC1THdqa1rBIjSFRryGH/LFc5gc1UEV6NSbzyAPHYgrCWrGah/QCeFSKo4WijlZzcMEvdDIWPuhBYRixWBGVHaXwSdqdW+imxcytB/9oxpXP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553889; c=relaxed/simple;
	bh=O7AK+avBtUq66QCHc+PycHss3yeDRao/n+7K4bdeeNo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PQ8RvQZQqdGRQIFT1RbN/vXB/Ofg1p7SectBqu49/5k6yUkqJJ3i98c0H0MVXca6DN/J6olw7pD+Oqy0cjmcLFHhIzwdPYeWKScNNp6x/+Jd6Qwm2YJ6y3EWiVuRLRHY1Pvd6kC+gGg3/2PYxj+7qHbrPApAV9If2O+VlJJhRs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=puXbA9qf; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="puXbA9qf"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e6b5c374e5so3835174a34.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 15 Jun 2026 13:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781553887; x=1782158687; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXCGDsnXgpty84dJ1mO0u39WICRv28gHhnNvC/hudJQ=;
        b=puXbA9qfqJ+bBzjUK5r+ZbWaip4cVNzeTs3GFyDENCFDQ/r5wXwvIbGUkH7yPuT/3u
         M1ozeBuFyId/QdEjMuUGAU+r4/Tb2IBJ+JUMiMwiDfvn+qEcOssAT99QOw23BtpaH+y8
         mxDUA/sQuvw82twpNpXHtzevHrF7WHyS2XEBR71C4G+4Wn1JNr4C00d+zQjvfledpeRu
         Z/pkNleMVJvsH58YVEsn9g1IIPl585clsORKU2hcd9Xvi/mYe39xXI7+Gy46BSpKIE0/
         TL9bIF5aEUcnsLuj/7AxK/vFUcGLh0zyvC6DoYOME/Lp6ImboMCiQKfmwl27OPVy3mtV
         vadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781553887; x=1782158687;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oXCGDsnXgpty84dJ1mO0u39WICRv28gHhnNvC/hudJQ=;
        b=dpBkECSyxWoEYfr+pwXF3qqJyd/TDF8HLUCVKsaszRpFiqltUkpEyfVkGvzYdyfnqZ
         yP43btj+1gWvXOkEIF61iX8+lNYU73Cxkz5o5/3SL2t7nf5HKkhGCnEzzgFELcsFasYb
         AWJXnit6PTmw/0OIpxHt2GOZd4d33Y7lbPNBExdIIki5JvLgaowHLIlcHb0W3XsecqVF
         tDoL64rRZuh7U9umdYXAL7kSvDDgBAkyPVsX6Z29OCpxCUMdHC6Y9Kn2xYF3AQgIC+F4
         MICXKXSw76ldne5jKf0GZW5wHFBrix/u3QGiRgZ7O2W68ykGr88wl3d748Vp5qFL5hyB
         If5g==
X-Forwarded-Encrypted: i=1; AFNElJ+hQiCTX+mfnmH2Qm3MstDWZSgo9kKaUY+sOAwHAcVww/50HCg/J5S7jKNCZ5zxB52gX7k+Ni8OFRWG/a3pfQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw45l6ynP7jv/T4d2rBvSG8Sc5ZDpNnTZiZg/wle0oMGggBafhQ
	wr2ZSDvzW/hcOptr1YZbI5qXWw1uKR8bfq+JlXioaWVpMe0MjJBAnw0V
X-Gm-Gg: Acq92OEV+Wfq/5wte6siB85Dg8LL0EP1hpnBdCIyKluJvDRtxnSnpsUg7YcElEbGkIS
	odc+lQKBUxwJ5kGPPkyDJS9meLv6KkOi7zOrEmtbSqEFBILUl3RIltPn4oDZivvzpP3le/77GIu
	q2+vxhHt1ygzBci+uTIDXOGD8zYoMWTtZLvSq0h8jyODWHxVXqrsQ7irJKmGwk9mdPTYF3b+H2s
	/3GkuTAfutwrLxDcBwMtk7ns1wR9atONjziVAR7jum3xea2BbccG++/I+UtxoeJsgAv9KW30R0z
	2uBZBsXaubj4LyzDQXBQIHf29+f0NwlZp6acVpGGVQXI8iz+/nZkA8liaH0n4rBeJE7gDrY1pGm
	FDTZLHv18LxoTvVrMGpXt8mSiJL01TCP/li20Pn/u5pW6RiUsH9ULHCixooNmhN993SP3n1GNkj
	TL0a+OBNCBNflZhtwApqcNWZXdS01MXCy5uWOlI6nnmQe0S6LwIP2lGnNcxDcQee8cWIgtQTb3t
	hYyBnoPJ6f2EjwvJM+XNQO+i1ed
X-Received: by 2002:a9d:7f08:0:b0:7e7:4a94:bace with SMTP id 46e09a7af769-7e8fc9ac8dbmr393027a34.13.1781553887063;
        Mon, 15 Jun 2026 13:04:47 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:44::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f6dfde9sm4892917a34.24.2026.06.15.13.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 13:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 13:04:44 -0700
Message-Id: <DJ9W57VQJQ0A.XOCAQZWY51HR@gmail.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>, <rcu@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH for-next v3 2/9] mm/slab, slub_kunit: register kprobe to
 trigger _nolock APIs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
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
X-Mailer: aerc
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-2-70a54f3775bb@kernel.org>
In-Reply-To: <20260615-kfree_rcu_nolock-v3-2-70a54f3775bb@kernel.org>

On Mon Jun 15, 2026 at 4:05 AM PDT, Harry Yoo (Oracle) wrote:
> =20
> +/*
> + * A no-op function used to attach kprobe handlers in slub_kunit tests.
> + * The barrier is needed to prevent the compiler from optimizing out cal=
lsites.
> + */
> +#if defined(CONFIG_DEBUG_VM) || defined(CONFIG_PROVE_LOCKING)
> +static noinline void slab_attach_kprobe_locked(void)
> +{
> +	barrier();
> +}
> +#else
> +static inline void slab_attach_kprobe_locked(void) { }
> +#endif
> +
> +#define slab_lockdep_assert_held(lock) do {	\
> +	lockdep_assert_held(lock);		\
> +	slab_attach_kprobe_locked();	\
> +} while (0)

Great idea. That should cover all kinds of cases.

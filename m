Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625913DEFFB
	for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 06:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792045938; cv=none; b=OwZOBaXSld5JjuD6dz6kz0s/Jmwre6t2g5y0cP2hk4dPbKaF1Gqns3qAjZThNad9mS6dEOslyzXBOdckwrqKhLajpVYgoNydh0hYTaTKSMaG6JKW3sVfeYO79CmPNZS0PA86K8M8ct4sCyO4q2f/LSPb8aeFxXqjTE/qZTP2c7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792045938; c=relaxed/simple;
	bh=qgNKuCufbexUiNnMd4UFYSMvMNsgy3mLjgSJhp++3Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKyH+78miQ+yXXbNV9039HRdhDm8vMY8Vnp/J4WkHm7Ms0U0f1mEWHJqfYOPos2XcsWISP8Dx+g7Zs6cdaRvTW2b6sjXI+KXwwk32sEcgyZ5s4jRPqks4F1Z047is9xFYm6p0mLXnDuYA/FFd4qjBWZtpsXwHzlL06lvKH31Vps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLI86ty2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLI86ty2"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1698ea378so39559045e9.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 14 Oct 2026 23:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792045935; x=1792650735; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lh/7skka0uDM8NGSUjtaIa1b4/VuTZ55Mdun5RSEQww=;
        b=DLI86ty2QMTgSWXE+11G942Z4RpR6baIV2aTbxbo8pYZr/4txSu2B6xQ4IQBdcN+zG
         UG+Cq/h2ZauVhJtiK7J00G5bXW73PKFOYW7XgbeOWUl+mrhXnPzRB++pBx1HPfNYki0S
         T3VCcnJfvK4asdyT03nZ28nW45QowlukbUUXhq0K0Ua4q/0ZeC8/M6ZRXfsOdzp+hT1Y
         C8dZpIW/Eo0s1kcilCGRk5DxoLN2mCfvzzpwq5suBFpjXRiuqBt3Y13a63l6YRdWQqWG
         /rCU8dBKlUPYINlTsMVd4ptnUpWfYyxxCi09aqLc1KAxVmCfblSjDg24zQIe4aXRQ7VN
         kZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792045935; x=1792650735;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lh/7skka0uDM8NGSUjtaIa1b4/VuTZ55Mdun5RSEQww=;
        b=VschvUl1wWbxSJhxPiwOrwe5FowITDn+2sMpysyw5CTRtoR+8L/zfY8mR4CU1ZLvso
         +r54GffwNcaCs24ZLfhhOFtiUG3GsN1v4/wQfRc1fPJTJbuMmVFv9BocK3c4+EpuP0ny
         IU/5UNeUoSE2MLdr0sv8A/D1mDG4uKB2KKmWX1+PmFmgV5TrAuWoMtYXDRirTvOfr6Fp
         RqIrG5K7Cw2JD7F3c1RKDT8Nl8hzGnV/DvXaSHFaZcDvGlgMPZ68bQ4irFLzGb7lYjoK
         0DL8/aMRu13ie0AA04DSVfxzYNfWzeDT5xg184hb4QCxj2o19L59fxfjVn4iUNIWDJVP
         IEzQ==
X-Forwarded-Encrypted: i=1; AKwUvBzQKU2cwu7SZvo2XaKICWk/Cx9CEBZNIcgpBeiQgzM7bmhr4LNGSTsQ+dJyTehxQnArJMVBbl3rUx24wGwi6Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYKUJJPxYTCyMEyPdBWBM75+g56/cr/s/TGx5fd2jgiMKb+7Ml02
	vWoXXmfaFfXKuvMqdBhSAYpZrD4tSLlxl06QtVDqzn9Wk06vdZkA51+A
X-Gm-Gg: AYBFou2iUYLA0Ee5GGUQXCf55XpxX/TxxeKHuG62aHat8URwm9YXzkNP0SGzxRJ+aON
	6KwEq2eUSl4hcSv5ksJcZF6iqJlcMwB5MI7nZLWJmMLwr0bcSOcCUNzPEFRV92VBDTNFUedimW0
	m4T/Yoxzn5L9CLWo+8WHkP27PajVDBie2SOE4gvViYz36+J5a/uQS4QSyIulXIuucOljtBV1uum
	i1+4krN3ZjdPgd+Pbs1NQO3NA6fH5G2G63vBtCk8DlMAw6oAkET6gzmZ+FEFGW8FS9qVY2rnos9
	WfNPdEp7EsYN4sOxxNlHxzbng2B8KIyTXhyAlvlvQFOx9ClhRbPQUoiJbjt5ofjkhSQRO7Xo7TT
	lqXK8APgCITTfZf1D7G3eetyhauAj9u8FY0t2+y4P/GgZgb/+e7jFT1ny0kTJUHsc0uxbZDpG3K
	ksxkuv8Lu9XnXTrXUHZgY2UlqDvsugHCbQ/7vws7wxBQjchX5Km84GntBKmdkLI7jfKcJUYsM+8
	T139ReGvtTwqRG5Qbe/j2upXFKYRA6wCyUzf9Y01bQqI3uTbKws7eEsZyhiXT+2JqGqwu9YbKWD
	n5H4hV/3K+7D3nbCzSxcr8MPUwMhXEap9mEw5Hc947UKYH9AykkQB824JLdQCe6vac8l2hFRouI
	=
X-Received: by 2002:a05:600c:3146:b0:49d:1fd8:b874 with SMTP id 5b1f17b1804b1-4a18e4af3a8mr376432265e9.19.1792045935458;
        Wed, 14 Oct 2026 23:32:15 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-aeb3-cd01-f139-812c-65df-b930.310.pool.telefonica.de. [2a02:3100:aeb3:cd01:f139:812c:65df:b930])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bf63567esm62999745e9.10.2026.10.14.23.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 23:32:14 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:32:12 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Clark Williams <clrkwllms@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Bradley Morgan <brads@mainlining.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Subject: Re: [PATCH v6] softirq: Preserve interrupt context during IRQ exit
Message-ID: <atByy9l7zW4TKtrK@gmail.com>
References: <20261011060742.30584-1-kmehltretter@gmail.com>
 <20261014120524.5e6e6efe@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014120524.5e6e6efe@gandalf.local.home>

On Wed, Oct 14, 2026 at 12:05:24PM +0100, Steven Rostedt wrote:
> LGTM.
> 
> So this handles the transition between hard irq and softirq?
> 
> I wish there was a way to get preempt count updated earlier on entering a
> hard irq so I can get rid of the transition bit in the trace recursion. As
> there's still places that can trigger a trace in the hard irq before
> preempt count is updated.
> 

Yes, this handles the hardirq-to-softirq transition on IRQ exit.

I am looking into whether the preempt count can be updated before any
traceable code can run, as a potential follow-up RFC.

If that works, it may allow the transition bit to be removed from trace
recursion.

Thanks,
Karl

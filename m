Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F113FC5C3
	for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 12:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782734784; cv=none; b=ClLLiFTdPATlaDNHFr4jFES4XYHAQO6vMukbXOicJYeHq8I7qDrtDbHs+iCiXxEZWqRVSGSva5Is7L1Z6f3V0/Txzb6dZ/IYVW35WRN97Tj8gWUC6t/7fcDDa52gOl23FcUfxWV/pki0UL38UlROQF177W2F4LoZqsjY+5wxHiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782734784; c=relaxed/simple;
	bh=s1Zt1nkU6AtVgXZaEG/G39e4v4/ThPUcVNXHxkYXdbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ha6VqdA8JgOY0mkd5H+7JXsZI6A+gdb8XunX9uB6FTCssUBeRPX7pTdGQy+h/9Qu3Hve6ijROw9CdOSsNdpQDuYrqcMiD2MopaCuVM/7M0ktga3XAhiNQERTDrnhlGTnuEL1Mv48ShShG0Tisk2YvVgXr5W2hZPStld7121WAmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EAcfhP4W; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EAcfhP4W"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4938d5f86f3so12090465e9.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 05:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782734781; x=1783339581; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hpoE++Dc53tmLwgNaoaxx1b8EdGUPsK36vhuvC33KIA=;
        b=EAcfhP4Wqq1hFYncFGVFWSxlVsAVBkqmQF4BEJZb3UXLdqrcJuIhHP8hMya+bZsyZ2
         MJg0kdk5Z2bh9yMyOItxy4WisCWTllgsbC6nzP+9f17avg4upGuMXHTUbOXUqfMk4z7b
         EG+/7gk1ae83yoaHK3pN3uMAks1HggOjU9N/R/nPStiRaBRQObYaMkJeHvrbSuDcWzup
         3gftg86KvfnYO1QkwysAuivAhSMmHPgsezyIMHJ4qV59zvAXczrS6GYC0HJRSG/UX+eC
         kL5nbY/iWezmVoETZr4tVlI42utlZ2s/KThyc6NXnkiEyXKKXDNdU4Wku7QbL2pO7WU6
         JCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782734781; x=1783339581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpoE++Dc53tmLwgNaoaxx1b8EdGUPsK36vhuvC33KIA=;
        b=E8fMpVYCELpZKuAGfJpy/LoPpwNrm5ncHySHHulBz6OtPKgOGZlKibMFCNgh0WxRLD
         x4tiQalHHNWZErGZqURvnqO1/r6lKSmuZW+nZCF1/BxZL5wOK9Lf3d5JpQS3XBMxVR/c
         DKsjgshfBBskNCpQztxzjSxWxucn2xvUv/aj8RVy4bzH6XxHdEKErVthWaFDf/JGIw84
         dt8XgKJ5B153SfdSWiFZQcJ6zl17cb+DM/BdgOEWSt7kQod8qfsdanbOcgQrzesrzCj0
         UJCiq5xVgo8O/A+ttoO3mzAo5+lksVvcIwNCi/fjYgvRRlF7Vw9P3etkJliPmYsXqOYe
         3Fkw==
X-Forwarded-Encrypted: i=1; AFNElJ+KbxEGF4dpZlceGUvQHjOwXsBrwqnZbUZTLBOcWt9kD34GdVvxhAwqoNkggDyje0vCMuYP7Py/HzIL5hvGNA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJXnNaSfa9joyHLN3tF3lq1J1DgentN9BjFjT1ka7f8GQSp/Hu
	5GABD3CUQ3rdB2LBOl2JCfcQZiiye/tfFEzZuGViMLmRUeyBvDRDoPfpnpBDs9OVX0M=
X-Gm-Gg: AfdE7cnbrE5L03cgr/yYMuRuxntSpLVWOCpaVYDMJMIFuPh8/qgN7HuNNrkbyQ17bf2
	DHtqlC3EzoTI0SJq7cQKJtFTO6nhGHKJKIzQZJ9XDptgvRG1dXXO2q1YCHEzzPPlQ39yFNTq5wf
	fc75kchanfX7NWJSa7Uim1Dui/ozp8UawHiCelZedOSpKw86NnlZGR++cpEnfV+EhO5x7vKRgqz
	+zt7WheAhwvCIWnvGIME5RbRcopBTEenwujTt0c5O0qaFX9VnmBY+BEIcLQVz2sNy5yvRbA3Z/y
	KDC4/YEaJ4CzUQFJrCb2kfMrDkO+i9nOB/YTnMIzIpd8jqSyRAE1eT0YY61LPw6VLj3AcHN/Ldw
	PHRDJ3G1qyn42RSI8ifKCMt8CXeZsLHLDtn0RUEa2t626FGfXpR+v92hHKn+Wi2LKlLJX4Yi3ws
	fv8XLvXNdzDrPIKpo=
X-Received: by 2002:a05:600c:c493:b0:490:e180:2e0 with SMTP id 5b1f17b1804b1-492663d6dbamr216363955e9.3.1782734780897;
        Mon, 29 Jun 2026 05:06:20 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268ff9f40sm286395495e9.6.2026.06.29.05.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 05:06:19 -0700 (PDT)
Date: Mon, 29 Jun 2026 14:06:17 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>, Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v4 5/5] lib/vsprintf: Validate spinlock context during
 restricted pointer formatting
Message-ID: <akJfuer6-_Kd_HCY@pathway.suse.cz>
References: <20260608-restricted-pointers-final-v4-0-9a436615799e@linutronix.de>
 <20260608-restricted-pointers-final-v4-5-9a436615799e@linutronix.de>
 <20260611120615-4252b75d-55aa-4bed-b64b-0316b2148d2c@linutronix.de>
 <20260625145115.KZ9l1-lv@linutronix.de>
 <aj6gdH2KS_XrNjIm@pathway.suse.cz>
 <aj6jcajaZXMF_BYG@pathway.suse.cz>
 <20260626170658.0bqzsB-1@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626170658.0bqzsB-1@linutronix.de>

On Fri 2026-06-26 19:06:58, Sebastian Andrzej Siewior wrote:
> On 2026-06-26 18:06:09 [+0200], Petr Mladek wrote:
> > > Interesting, does the spin_lock_irqsave() even allow sleeping under RT?
> > > 
> > > I mean, does spin_lock_irqsave() violate the raw_spin_lock
> > > vs. spin_lock nesting rules?
> > 
> > Ignore the silly question, please. Sure, even spin_lock_irqsafe()
> > is a sleeping lock in RT.
> > 
> > That said, I am not sure how to effectively pretend the right
> > context to lockdep. It looks a bit ugly to disable interrupts
> > around all the code which is guarded only by a fake lock_map.
> 
> That splat is from !RT and here it wouldn't happen if interrupts were
> disabled.
> On RT that interrupt (softirq) would not interrupt as such. So it is not
> possible due to how softirqs are processed.
> 
> My idea is to remove that thing so we don't have to annotate it.
> The reason behind it: There is no added benefit from my point of view.
> I can't think of reason to return real kernel pointers via proc/ sysfs
> to the user which depend on a security policy. The %p will return a
> value which can be compared against other values and check if it is the
> same or not. The root user or dev can either disable this hashing
> behaviour or use %px while debugging. I haven't figured a reason why
> this is important.
>
> If you have something, I am all yours. If not, I poke networking next
> week and try to remove this entirely.

I am all for removing the restricted pointers stuff. IMHO, it has been
obsoleted by the generic hashing but it has never been officially
mentioned anywhere.

I hope that networking guys would take it.

Best Regards,
Petr

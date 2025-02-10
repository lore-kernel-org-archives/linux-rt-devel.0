Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C67188596
	for <linux-rt-devel@lists.linux.dev>; Mon, 10 Feb 2025 05:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739164935; cv=none; b=ZFzjLzEiZhyhr9lfOD8CKl6AJGd+EmWn8EcqZ4iq1bfZ1K8riFSYU9Q8AO13Kz2TGQxCk4OvxM8q2fcTaAst5TwD1Hl/MucmTFgxzbh3VNJxjF/GRz1sj8xtRAWp7tgVYwUUWdRun/Ftba7DgmDeaCCjls2ZKsLXzy1Z/jObTjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739164935; c=relaxed/simple;
	bh=AfGuIVJBNjMTAfPl/3or03tpYTjYY0PWai1Zt7mwR+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgVbHjVRux+WOHBntOpviC4pxLopx2PZlVuitkngHwn6Qet3ipEKeIJRpOIHFTAaGWWssOzBnVvt7ehzQUR07QCHHWGxB82endVeugin6yJJT9GUDbWO02IeUt79ZssWlPB3in5alWuN9MiF24cQ8HtAqH0yoPUW8uhqRLPWHM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EayFJqKU; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EayFJqKU"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4718e6fffbeso8573181cf.1
        for <linux-rt-devel@lists.linux.dev>; Sun, 09 Feb 2025 21:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739164932; x=1739769732; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NP6FiyAFqZZfQX95AIbNAITU3lunO+K/ljPYqazSung=;
        b=EayFJqKUxQqvXlBrz8na8IHbQna1g6IefUD+Jnp9+6lzZ+biFw/DEuiea3qnSQYG9r
         ZLfQl33gMDlMcErP5jVBWQix1hJC0MSrU9cJyyHvGadX6he3kdTkFsVcA2r7dZ4hD5Ff
         MaBafy8vJmHLLY9cQKZfGi+ggF8lIZfMcpZT1sUFRNCYtb9pgRccSzLXZ5cJoa7O6uiN
         tsNmb641JlPxMswStuaveFKVPKf0HZpYw3ZO296MIQSs3zLRMh7NUCDwyCRttf4uGytJ
         ASZgLmrYBkx36jw2NdvihbX8TdvfazDXkcM91io5QguWfOo7+PQVD4YaRtxMgrFfcXAg
         OsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739164932; x=1739769732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NP6FiyAFqZZfQX95AIbNAITU3lunO+K/ljPYqazSung=;
        b=O/++SV3NUoI0obiba1tRUTHQF5UQ0Chd2c3BYXq1cUqMGlFxN2h+hSFqty5CdNSZog
         cirwGNVuMo1QdYIvEwag/lf++J35hOlg89ZFY4yG2PnAxJUlvxZ0odoPq+EnucKytwS9
         awesgdsKNAad3CWEl40nxOQPA/kspQUBrWzHYShOMtoTmUdwTbfHmKtmq79iL1PlXtki
         pNEuO5CkSeWXuO8Mfzcde5EVD3OANav/pMl6oIqqCY0ZLXV+NWqjmcLnYNjZs9T+xjEG
         4hGvYt7jzAJwlFSz5nDZqIPMBzEoQqSTb/0WWwRvNiNCg68Mx+w3lH6sHYcDrR6+kBed
         tlpA==
X-Forwarded-Encrypted: i=1; AJvYcCVFUZRnxH/+4shZBA9kL3eYFQFS6yTV+kSH3wXtb1iKCjIOcxiSYHVqjuOFqJdDulNxyNwLjVLJGLP8Cu5oZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyylCPfLiPc82DitjWAdjaQb7LtuNkzkA0UW2wmVdEsoRF7m9qy
	P2TdOv7Hp2axBZUc63arcv44QMRtIB0f0DRvaZKCHFzRGIHK09x5
X-Gm-Gg: ASbGnctiOrJYGrSU8LyJ5qVfuL4bm+S3P9xa7ZiQNEmue39mZh1NLU8P5PwM5OaMV3Z
	txeC9OHddlKtyC4f7hCvZtSMDcMGwmQljSyTQa52CHcVFEf5+TQi7HLA9Pe+QYEU7myiDoFbVtj
	K5tOSb76jDjMuNuB5opBx/8FkoLViZul4yfHSnNS+0U3I5Ir4ZCh1Sk2FeGX0GbzXBuoDUe5q/h
	onFr2hd1boBIndqFT1CfvuysALo/rA1Jnly3+xCCnq0FXBpILFb70VQftAAjQ+sYdY7MsO3QAtM
	uV6wWRNqOUwdSdPArzr4/1KkrRLUNMoqy62ri+BoYQJyjWy6ErKCOV/i7tQ79xzPhuhR4QJLSU0
	9AyuvhA==
X-Google-Smtp-Source: AGHT+IEgE2AWt7Q/LqShSB6UQ2Ks8qY3J87XFoKFmjC5yzmF0ox8hp2I4vOzIdC/e3aHCSnNt5DexQ==
X-Received: by 2002:a05:622a:199f:b0:466:a0e2:ae8e with SMTP id d75a77b69052e-471679a0054mr103982151cf.9.1739164932479;
        Sun, 09 Feb 2025 21:22:12 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4718e8f5059sm11655911cf.7.2025.02.09.21.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 21:22:11 -0800 (PST)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 51CED1200043;
	Mon, 10 Feb 2025 00:22:11 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 10 Feb 2025 00:22:11 -0500
X-ME-Sender: <xms:A42pZ2EwlcHQ6eJ3cCpFtWkK0NP570TY6QOFGSk5InX3AxMnSJrXNQ>
    <xme:A42pZ3XbXnUWx-Ctknw70BnxDxQHMQjzoXK-tcHumSzVAVGrTPgoerQ-VYrG-L-qv
    1CoCDmlqdZkHltCvg>
X-ME-Received: <xmr:A42pZwLnyu94Io3Dz-mrLmEnh7U0J2AvMZb3A5iv-GdjIzLRjZ79FaJphw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefjedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceo
    sghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpefhte
    dvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedvvdehtdenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhihohhtkhhkrhelkeesghhmrghilhdrtg
    homhdprhgtphhtthhopegsihhgvggrshihsehlihhnuhhtrhhonhhigidruggvpdhrtghp
    thhtoheptghlrhhkfihllhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhloh
    hnghesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgt
    ohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpth
    htoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopehtghhlgies
    lhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:A42pZwGUq1uy1NXMck8FsdutJtQlrHqzWvDtjbA__alc0vJg4WIoxQ>
    <xmx:A42pZ8WuNrrqD-fnAbL9JQNaZmq5lbZITCpSGo0DAup8bNkgtmu8Fw>
    <xmx:A42pZzME0N5nG2Yau8g4BxEoS7WSKfv4mO2ReKlSaIJnseto1vScOg>
    <xmx:A42pZz0t-U2B79JqIgAnLqnGYtfaEVGqeX_VNSkv8v4yrK1p4o-00g>
    <xmx:A42pZ9XdqbRSUho_LzY2OgtHmzexyx6iSYOkrKOYJJpjpjdq9pTdTQf0>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 00:22:10 -0500 (EST)
Date: Sun, 9 Feb 2025 21:22:09 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: bigeasy@linutronix.de, clrkwllms@kernel.org, llong@redhat.com,
	mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
	tglx@linutronix.de, will@kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v3] lockdep: Fix wait context check on softirq for
 PREEMPT_RT
Message-ID: <Z6mNARx5H65MPd1-@Mac.home>
References: <20250118054900.18639-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250118054900.18639-1-ryotkkr98@gmail.com>

On Sat, Jan 18, 2025 at 02:49:00PM +0900, Ryo Takakura wrote:
> Since commit 0c1d7a2c2d32 ("lockdep: Remove softirq accounting on
> PREEMPT_RT."), the wait context test for mutex usage within
> "in softirq context" fails as it references @softirq_context.
> 
> [    0.184549]   | wait context tests |
> [    0.184549]   --------------------------------------------------------------------------
> [    0.184549]                                  | rcu  | raw  | spin |mutex |
> [    0.184549]   --------------------------------------------------------------------------
> [    0.184550]                in hardirq context:  ok  |  ok  |  ok  |  ok  |
> [    0.185083] in hardirq context (not threaded):  ok  |  ok  |  ok  |  ok  |
> [    0.185606]                in softirq context:  ok  |  ok  |  ok  |FAILED|
> 
> As a fix, add lockdep map for BH disabled section. This fixes the
> issue by letting us catch cases when local_bh_disable() gets called
> with preemption disabled where local_lock doesn't get acquired.
> In the case of "in softirq context" selftest, local_bh_disable() was
> being called with preemption disable as it's early in the boot.
> 
> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>

Queued for future tests and reviews, thanks!

Regards,
Boqun

> ---
> 
> Hi!
> 
> This version uses CONFIG_DEBUG_LOCK_ALLOC instead of CONFIG_LOCKDEP.
> Thanks Waiman for the advise!
> 
> v1:
> https://lore.kernel.org/lkml/20241202012017.14910-1-ryotkkr98@gmail.com/
> 
> v2:
> https://lore.kernel.org/lkml/20241227040824.83626-1-ryotkkr98@gmail.com/
> 
> Boqun, let me know in case if I should add you as <suggested-by> tag.
> (Please forgive me and ignore if not what the tag intends for... 
> I thought its appropriate reading the document[0].)
> 
> Sincerely,
> Ryo Takakura
> 
> [0] https://www.kernel.org/doc/html/v6.12/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
> 
> ---
>  include/linux/bottom_half.h |  8 ++++++++
>  kernel/softirq.c            | 12 ++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
> index fc53e0ad5..0640a147b 100644
> --- a/include/linux/bottom_half.h
> +++ b/include/linux/bottom_half.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/instruction_pointer.h>
>  #include <linux/preempt.h>
> +#include <linux/lockdep.h>
>  
>  #if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_TRACE_IRQFLAGS)
>  extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
> @@ -15,8 +16,13 @@ static __always_inline void __local_bh_disable_ip(unsigned long ip, unsigned int
>  }
>  #endif
>  
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +extern struct lockdep_map bh_lock_map;
> +#endif
> +
>  static inline void local_bh_disable(void)
>  {
> +	lock_map_acquire_read(&bh_lock_map);
>  	__local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>  }
>  
> @@ -25,11 +31,13 @@ extern void __local_bh_enable_ip(unsigned long ip, unsigned int cnt);
>  
>  static inline void local_bh_enable_ip(unsigned long ip)
>  {
> +	lock_map_release(&bh_lock_map);
>  	__local_bh_enable_ip(ip, SOFTIRQ_DISABLE_OFFSET);
>  }
>  
>  static inline void local_bh_enable(void)
>  {
> +	lock_map_release(&bh_lock_map);
>  	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>  }
>  
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 8c4524ce6..f0edb0abc 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -1012,3 +1012,15 @@ unsigned int __weak arch_dynirq_lower_bound(unsigned int from)
>  {
>  	return from;
>  }
> +
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +static struct lock_class_key bh_lock_key;
> +struct lockdep_map bh_lock_map = {
> +	.name = "local_bh",
> +	.key = &bh_lock_key,
> +	.wait_type_outer = LD_WAIT_FREE,
> +	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_RT makes BH preemptible. */
> +	.lock_type = LD_LOCK_PERCPU,
> +};
> +EXPORT_SYMBOL_GPL(bh_lock_map);
> +#endif
> -- 
> 2.34.1
> 

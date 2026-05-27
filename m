Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089BE241695
	for <linux-rt-devel@lists.linux.dev>; Wed, 27 May 2026 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896732; cv=none; b=Aj4sB0YeNw4HT6I6YZOiI0EC2cJJT+FudaWDV927dZ8Qoh9H7A3cYnje1wUNgJ0s8HgA1fRlg389Owx8kxWMPeTnso7TttyI4wyuCrIMP5PjNWoH4enPnXpNHwxecOj4FRGEtIdFe6zcjovsQLT74kcFCdrrTVtL2j2oqD3cE8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896732; c=relaxed/simple;
	bh=MmHt+UFOdVwRwdDF9g5bD5yVltg4QmEY1TCRMiU+UGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqDuU22jB39+APT9rI9Lt3/h1vetBLV6r+1yNNJZ8cs9FlIKK+fEiMhQOLkumnjlu6+euov4n4t5fImXLQZAPRBh6JOwytYTWD8WbgCvfa0kbhKA2BBny2+XpPf4E8pGAxd5/NQ+COI0BmqtBYrTuxef+lksxDUmhZLgxhXl9jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SP6gxDbM; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SP6gxDbM"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso64152045e9.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 27 May 2026 08:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779896729; x=1780501529; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zv7j3mYs+kArFa1PD+NhbMjrh+f1ty1pTSvGqulUIwI=;
        b=SP6gxDbMHBMrI7Xjt3dQMBKJbituS+i9qB6pGUX4RunFR0aGzP8PtUJn3gidhL4tCq
         SLlSKplfdEcrRxo4/j0gKssgCAyX7jdfzMJCA4nEVCHhg9jO4bYahKbMlkXbMnMfKM8I
         n9nXMPjwX6li2jgrIVqnLUAEjCjjsOmlXvq3hir+6MjsgJV80KT73UBg1emAMEjO24b7
         HHstjpEWEb/lGfJj/ruNSXBNUCZObXe2iIkESNq0gFyY0wQOz+fO2dQuo7974a499291
         JHhw6xatNl8sRBdTcNPXINeVCCNQw+0cJFpdkW3sXpNA6V7KLPH2jRVipHoek3IMx9Bq
         KpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779896729; x=1780501529;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zv7j3mYs+kArFa1PD+NhbMjrh+f1ty1pTSvGqulUIwI=;
        b=rfgx1mFEF3sey7/hyUwLxcGP2n9jWzbI7C1OgpdUNNBqsHd+W1DAEYl1+AJxSAcIlh
         u/S0Q8Bmns+mlRpn5qWyy9iQh/di1krVNrSud8WSmo4K3UbMQtNNMt/+Cvg4aRuOs/+L
         CZwNziaWQe22wfp/aE8Muyc7HIpXLHk5oL/mMeZyRnG26L1n1UiIiBYFPLZ5Urf1yGO5
         JekQs/Hf+YTqWPkQhr9uGegZ7vf40OFSeKylrc3sA9xwgbyJqzCp7cvq+AXqj9qral86
         cxSryneviJpa8MxLsTE+ShQX3WHJM/8KRbE3dHrcywdUlp7W/u+xwgjxmlbtRa362afq
         plOg==
X-Forwarded-Encrypted: i=1; AFNElJ+0CSQVM7nUuSfR0G6LWsY7/hPOuznU7Z6MYVpCNgDBMndWdAa8dF0p0aIdxp9ECk1W2OeZMh4rH9y29BC3pQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwU5YZB5T5grYkhmYgZtCp5iCFRqfCU9FbSkEnoe1UPl6+CP6qA
	KA4uUBg9UTgpNr+h+265L1OPrGdAHiSyKBowPZuLcvLdttX4HiGHhe9dSLQ+dKcpjig=
X-Gm-Gg: Acq92OEJYcfucGCVgbbmjEQWKpekGQcFgpRjAA0v+J0otxCPINHGdtVDfuhUX3fS6EZ
	8tT7JQPT46pIgjfCZuw7wDCMHMLI5ZiV1m6AxrTrLPecPWDZ/LS8nGfTxr/ElrXBMoPOh5d7gph
	RAlzVJhomyeadg0m/wZy2dTuMZbE4l15MyaSQNUhHlhhbdO7IjHR9eGoiGr0DVhdgVDKtMajsu3
	3wso3F/vPNWHN2SbZMYg4dGVNr0QFg+jIUWODsRTGmXVQkubNyog/aSL8t/P+LJPmb25zF+cSV4
	rf6v6/hz6i+ybpG/6l3YDhGVD0DrzWgMLu0t9FXjwCZqTL5xN9HcApUIzCTE3YVrDRgKpAP6LFy
	A2Izx1Ew445P+YFDVQvP+//BgcP6u0Yg2lObyfbWZMzNa447hjIEheeHfjsOo1iXr7XbSDmQZlO
	dgF5Gv9BYwJg+1DM4Cw+Ul4xBk56ACcnyrgypGtvmc
X-Received: by 2002:a05:600c:64c9:b0:490:53d3:47a9 with SMTP id 5b1f17b1804b1-49053d34b35mr328797395e9.3.1779896729353;
        Wed, 27 May 2026 08:45:29 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490452765f5sm420980525e9.5.2026.05.27.08.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 08:45:28 -0700 (PDT)
Date: Wed, 27 May 2026 17:45:27 +0200
From: Petr Mladek <pmladek@suse.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>, Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v3 5/5] lib/vsprintf: Always check interrupt context
 restrictions
Message-ID: <ahcRl6kStEGreUT7@pathway.suse.cz>
References: <20260520-restricted-pointers-final-v3-0-76bca6a6ab3f@linutronix.de>
 <20260520-restricted-pointers-final-v3-5-76bca6a6ab3f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260520-restricted-pointers-final-v3-5-76bca6a6ab3f@linutronix.de>

On Wed 2026-05-20 10:40:04, Thomas Weißschuh wrote:
> When kptr_restrict is set to '1' restricted pointers can not be used
> in IRQ context. As kptr_restrict can change at any time at runtime,
> this means that restricted pointers can not be used from IRQ context
> in general.
> 
> Add some assertions to detect misuse early, independently of the
> runtime configuration of the test system.
> 
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -871,6 +871,8 @@ char *restricted_pointer(char *buf, char *end, const void *ptr,
>  
>  	guard(lock_map_acquire)(&vsprintf_restricted_pointer_map);
>  
> +	lockdep_assert(in_task());

It might make sense to do this assert before checking the fake
spinlock. The task context is more restrictive than then
the spin lock context so we might want to check it first.

It might prevent confusing reports about inconsitent IRQ
usage. This function should not be called in IRQ context
at all.

Otherwise, it looks good to me.

Best Regards,
Petr

> +
>  	switch (kptr_restrict) {
>  	case 0:
>  		/* Handle as %p, hash and do _not_ leak addresses. */

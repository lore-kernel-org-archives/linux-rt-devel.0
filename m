Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699D730CDA1
	for <linux-rt-devel@lists.linux.dev>; Fri,  9 Jan 2026 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767977669; cv=none; b=FFGH7XJoTvXn+wKNYnKMi4Z6r51xTAp1qkmn8dsIQxbzXxWd9dV/V2wCZmdLtSxS2DsQHHPi32hO53Pm4wd9sWbEJR8tBnseMDUXGSpjEKbCKMIXn0/h4lGbVh682xf84grmi8yurgpIO3nZGb4RBdlmtHRngGB1MRo4VlJbgk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767977669; c=relaxed/simple;
	bh=8Bi0wnXNNoO6BUdS0PfFuCedKJjgtAMsXms/52+KB0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1Fh0xm58UkFnKOcYXvhktMeMUEg30N6hmB0Y5Pk6nIC1xmV+BJynA9Nub/TiI87+eL2pWe45b2aV6ZaTQAIHhy6CtIT9+Km8e+Vb7lEEO5niXT0/lqODutXU8HRywv6o2mIlbbzYcZr3S+3A4WF3B/OI5kH+5PXGDKJsClbGYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A+yCvXCF; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A+yCvXCF"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-432c0b6c52dso516071f8f.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 09 Jan 2026 08:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767977667; x=1768582467; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWjDb7yk2PJrpDy9G76TtUQePp9Bz/8mN/oD8ydAWuQ=;
        b=A+yCvXCFGqNu/Ff8w48vFSGnYC4N5tiZaWvp71ZYpAkYxHqUqOxIzFg9yCgSuAT7o2
         Hmob8AhS2Pt498lZMhBYAe4NA6lg4Be9ekQ/naBl+O/6ZWmNcnh5yCJThemNbq/UsL8u
         dEjLjJD0AQ9FBmeiChaQqs4/eBwSlGEP6TGXFZXF3SAEBInIpBADjQvNymhsEOVhEthV
         z3PlE9UBImcbYwYso+q6dN9jckLrB7ovxFRABs/nuZwUfbZOsrwOrx2BvxGYwEbjBqpx
         Ar+bgsxA1KwrA78QWhvJOyGKlsIsd/dW6xxeSCkTxRNVurcOsAW8lIvOjavZz9toCFzh
         BU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767977667; x=1768582467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nWjDb7yk2PJrpDy9G76TtUQePp9Bz/8mN/oD8ydAWuQ=;
        b=G2wpewx4wA56hD1JPb/akYvMhPi6wC8SJmKldtn1qyO8lcMfFGNWiY7+ajFkLiDtZd
         +HKfbpZ5MQ6eM/IA61mi+U5JEVD6Vie/qugIUgQwmoNnX17wz4/MVsrzGgfsX+hFXxxP
         QXmpT783kvq554B3zBDVphhIqYfxyY5dt70DtdSnS265Jks5scjKcPaL0KBmfDeSxlFP
         TOp1mNR7c5ITqymupMjkd33aR6nFKuw464Est7i3rxfDGAv5K5ceFnzXyS5ARXXFYH4h
         dZG/bOJ0R3Qfd26WYPDZc8U9/gmbj4y85QZwgd1Ax/d0iWrovGl1YSRRlBfQzCv6YJdV
         /hQA==
X-Forwarded-Encrypted: i=1; AJvYcCVYNN6dXmyCBRfI1svUFN90227Pkw0SkrlDwNHQZjp7QaJ4uB5Rm/U0mbfR0ojOZ3aVOygwWnF7VQKJbwJ6QA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxoM7AHwM9fHFRfRwIoPrdCC2HfhQ6Ciwxl5a3Wtx5y+pTP/srb
	Wg4vbCGFE1xZc3i88t3uparX9DQ/m7k46PhEcek/YLFfm9q2x+KBf99m1EzBZA7wc1I=
X-Gm-Gg: AY/fxX5iOQL4Jh1XljLM86fUKHhMPEdPaxGug1XndjX3rwopm7KyiFiofUFRcVF2nmS
	glERirHfmwlow/ZNPx72PCbA9mWYIA1aUDYO2Q7vyoN0UyeFrJlf3Y5ftj/rw9tzdSkMHGPaZ9S
	+dOVpZvXpd/3C2tZ0M4Y9V6qXH2/7p2OkCzTYx7ZAszwd4Paf7J+GfKqVPkZZB7zDTlu1ziVt+n
	7aHjpI6kTuhvATJLgCtTkPcDrPgIwjYHonIfKyImhM9xAl7c4h7OyB40k7h7vSSmhfA8UXbL7P3
	BkNjRrO4ZW5mtHblSnobr/O2AOh96ZsiX+ZmS0nwyGSdB3llvj8YvWDu9F8Gv89gMwbup+KIGBS
	gO2m9eptsegpvX3TpKXROLKrDg7a+JxE5a441L/fNNGcgHuTulHbuGygTW1Kn+Jew/UBq8dEd3E
	/bUexlBuJ0kSeiXJhC+pzW+fvhyDgrXs6KwaGu6y5pBhRQWHj5G4sp1UFLnxACQtfk2pcLayHbm
	TxO
X-Google-Smtp-Source: AGHT+IFG2ZorT+yxyJ5NBPvYvfTR4y6bLlncZmb9SB5fsFuF81d8MrxzFB1XL1V3NoA55qYcPCf7Ww==
X-Received: by 2002:a05:600c:4e86:b0:477:5b01:7d49 with SMTP id 5b1f17b1804b1-47d84b3377amr68838595e9.4.1767977666780;
        Fri, 09 Jan 2026 08:54:26 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f6ef868sm214237245e9.11.2026.01.09.08.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 08:54:26 -0800 (PST)
Date: Fri, 9 Jan 2026 17:54:23 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] ring-buffer: Use a housekeeping CPU to wake up waiters
Message-ID: <20260109175423.70ba42d7@mordecai>
In-Reply-To: <20260109111506.66ad545a@gandalf.local.home>
References: <20260106091039.2012108-1-ptesarik@suse.com>
	<20260106170405.425f469e@gandalf.local.home>
	<20260107085009.58fcffd4@mordecai>
	<20260107105137.4cf9a67e@mordecai>
	<20260107111709.0d115cd8@gandalf.local.home>
	<20260107111935.3befc296@gandalf.local.home>
	<20260108093932.252f6bc7@mordecai>
	<20260108115800.7a7fc8a7@gandalf.local.home>
	<20260109095756.13deb429@mordecai>
	<20260109111506.66ad545a@gandalf.local.home>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Jan 2026 11:15:06 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 9 Jan 2026 09:57:56 +0100
> Petr Tesarik <ptesarik@suse.com> wrote:
> 
> > I have removed both "inline" and "noinline" in v2, leaving it at the
> > discretion of the compiler. If you believe it deserves a "noinline",
> > feel free to add it. FWIW on x86-64, I didn't observe any measurable
> > diference either in latency or instruction cache footprint.  
> 
> Please add the noinline. I went through and added strategic "noinline" and
> "__always_inline", as well as placing "likely()" and "unlikely()" and
> dropped the cost of adding an event from just under 300ns down to less than
> 150ns.
> 
> This code is called during function tracing (hit at every function call),
> and yes, every little bit helps!

I'm going to wait a few days for further comments, then add it in v3.

Thanks for your time!

Petr T

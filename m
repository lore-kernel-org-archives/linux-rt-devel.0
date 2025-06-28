Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BD6220F32
	for <linux-rt-devel@lists.linux.dev>; Sat, 28 Jun 2025 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751098087; cv=none; b=lyIEVR8+H1nENHMOdP7HDRIK8b6X3k1g5tYBhSBZ1PQLW6Ywkw62Wjv/OHexsTPC8hAfbQuWmRChy+jrWCwMIldMkBLGqgP+knLzoitZlAGCjeBs26++BlD45Djq5305129KXB+Twqy8tY932n4OO316irjqBGJ65jN55657wJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751098087; c=relaxed/simple;
	bh=3UhXg0hgehcghVQpMtzWRIUY64Ax+APcPYx8IU8QTnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8mrcU9787bBQzGSSvWFeeZkZii2Y6j9n2bXhGv1MsGnKknOkr/a5ta/Z9uOUGo+qaDaYDg6Psj+sS7I0odf35irsxwWMud51KaToyAGJ+kiKYggZ2vE0pLZp+eS8YlSP2G/XSEVe4TSwZsqWv/6ui2S8LtU69kX+kNKQL3kylA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S5eijEON; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AdyafLun; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S5eijEON";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AdyafLun"
Date: Sat, 28 Jun 2025 10:08:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751098082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HoeSQkIBv25z0Tbqv1MKQk4IGR8oe+jHuinax4DpWyQ=;
	b=S5eijEONnGlCuaVoiSYRx2iBQyhh9SgR6PdVtRSCI9YWN5+jg/XbhTYQ7ihZNx8oKPyqKg
	sKCnzMEebZDIAVjtAO9si3/dOZQUHqmlWLPTROVj9WW3uSawvkdTWcBgePQgkZ4QUr8GwG
	pVbGomz0GjDWEF9TwI1ZQBXxFDNmgPAwrTli9fqT8MPAcgesWLk1Tf1Ts1Rnq3RtuOFfFu
	URyW/M1PiZhOY/ymf/Lx/P1Wamy2oakQv04QJItuaT7v6XK/Qwk4e4MYahVIg073QLQQrX
	XtUaT8aEQagF7yFl7n+iXT4FMqkTiQzwi8bqroSW8i8kh15z8bkUTARU7MtSWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751098082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HoeSQkIBv25z0Tbqv1MKQk4IGR8oe+jHuinax4DpWyQ=;
	b=AdyafLun3rD95IR2OrjZ34cvouFduVwt+3HuO6JKUfaO53X19279Ch6vACKkuCuloC4ekv
	CgqQmloQw1TMtxAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v2 1/1] local_lock: Move this_cpu_ptr() notation from
 internal to main header.
Message-ID: <20250628080801.qZq1OGYR@linutronix.de>
References: <20250610110205.1111719-1-bigeasy@linutronix.de>
 <20250610110205.1111719-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610110205.1111719-2-bigeasy@linutronix.de>

On 2025-06-10 13:02:04 [+0200], To linux-kernel@vger.kernel.org wrote:
> The local_lock.h is the main entry for the local_lock_t type and
> provides wrappers around internal functions prefixed with __ in
> local_lock_internal.h.
> 
> Move the this_cpu_ptr() dereference of the variable from the internal to
> the main header. Since it is all macro implemented, this_cpu_ptr() will
> still happen within the preempt/ IRQ disabled section.
> This will free the internal implementation (__) to be used on
> local_lock_t types which are local variables and must not be accessed
> via this_cpu_ptr().
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

A gentle ping.

Sebastian

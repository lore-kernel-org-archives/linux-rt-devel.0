Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2448C3CAA5F
	for <linux-rt-devel@lists.linux.dev>; Wed, 30 Sep 2026 06:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790749562; cv=none; b=kxtCsZfzUmI1s2n98cWFq0qutiTRlOgwavIXW09QmB108aPigjdmj5Fy/TbmPbtJeD/VqoBPw7qz4ywhpR195xY1unru/YN+2LWZ/9m105ec1lapthml6rxo1QXWaULEZTsk/SqNeo3HbdCXq5QprhF7soPRZwIj3qeecRRmyos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790749562; c=relaxed/simple;
	bh=FuMDGz2VIpv4BTTMao/q++AI8J1soWoRti4IWBFoLyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVc4urBOhn1rYqxNAMCD0rHdJXW6ub40IFT9MqSyBJ9Z4WOD9TmNzT0uWw9CjVfNalVZxNL/8KMdHP59P4fOtPN3HiHiVikbCR45gDEj/gIXQIeBSDgOBxiiEKN/Cztiv7VaG2hfQko5aSe43/j8fBl1AGyKjizrLE9Zfs9WPqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2wgRoWTl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IdLDSpqo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2wgRoWTl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IdLDSpqo"
Date: Wed, 30 Sep 2026 08:25:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790749556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wOaKLnO4Sb0x5bHZez+joNqVAccae76j6r+xOC/BK78=;
	b=2wgRoWTl1ZHXZBW9w2FGF3Scl3DJc0iRaELlmj9hginOvRPmCBK/FA+Ug5AzNZP12Glf0/
	x6eqP6ShQkX+0vHW0pzZXOYFiCdtY0GMP7OWA7mLfcnUQ0pz/ZtVi91qicnp/ftPW8JVx0
	n59ZFAClZGSWd232/ZbIXkwvFqUPyTNGxiNFvVB3ba2hKDDdnM2O1UdsVNsFtd6CD4rJCt
	xlwT4WeGw+sguqRRhbxZ8Q4/xkXLW0mp6tlSANZ/vqUjyGR7Kp+T3CLNdVBuTj6tx2n0Ft
	Qwi6O9zyskIwcFSYHgBTVoiAc63DZ+ETNhCGaukrJhJcPqMnpa07e3ZacvZ7aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790749556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wOaKLnO4Sb0x5bHZez+joNqVAccae76j6r+xOC/BK78=;
	b=IdLDSpqolLNR8maPxVs6VOHUfTt6BIcJdpqST2TBLldQ/6f1qm8RGKvBsRKUg7NRkZ7bBn
	5jQaciaPj9B9H7Bg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Quchaosheng <quchaosheng000406@163.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Stultz <jstultz@google.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] sched/proxy: Correct the SCHED_PROXY_EXEC dependency
 comment
Message-ID: <20260930062554.2AwbY2nX@linutronix.de>
References: <20260930025824.79296-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260930025824.79296-1-quchaosheng000406@163.com>

On 2026-09-30 10:58:24 [+0800], Quchaosheng wrote:
> The comment on the !PREEMPT_RT dependency reads
> 
> 	# Avoid some build failures w/ PREEMPT_RT until it can be fixed
> 
> That describes what happens once the dependency is removed, not the
> reason it is there, and "fixed" is never defined, so nothing says when
> the dependency can be dropped.

No, please leave it as-it. This information is the for the end-user not
necessarily a developer. What you add is an information for someone who
can read code. This information adds no value IMHO.

This is enough as it is. Someone familiar with the scheduler can
certainly remove the dependency while adding the needed code and
replacing the current PI bits.

Sebastian

Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCF0220F3E
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Mar 2026 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774453961; cv=none; b=Web/0ktvYirPHvQjcZTAuwBjuoRjV2rEL+TRqkTMEJH2fBlL/rLOx/PrFV0JNZa6yvRn/OWTeP29tGTrTL5wPM/fSXgQsIyWxuloY1T3PpzRoN76CewBCXvtBe0bFi8rHRAhrmuZeafkC3BGEBhSvTBfYgQjANDGyUcquQk6C80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774453961; c=relaxed/simple;
	bh=2QtpNYRay1BPQEN0Xg848dl+xD4/yzIdZoAXIs3j7QU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lT95AS0d9UHnzD/yIzfOD02YB91UAWTx9jNW4O02d3WZ01UdKUvdEq0vYGLUF9yZAI/3JSSw4Nukb1vBy3ZSTGHp3CNMXDsxYHzDcug1FIvCgkaY7W9fzgUAVnwkBJaUnYD7xoSMUd4IKTixnrO+3NGLD2seheiqdExS0/wRHKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 1CDFE13BB75;
	Wed, 25 Mar 2026 15:52:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 5062B2002A;
	Wed, 25 Mar 2026 15:52:31 +0000 (UTC)
Date: Wed, 25 Mar 2026 11:53:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rt-devel@lists.linux.dev,
 Clark Williams <clrkwllms@kernel.org>, linux-kernel@vger.kernel.org, "Paul
 E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v1] irq_work: Fix use-after-free in irq_work_single on
 PREEMPT_RT
Message-ID: <20260325115315.052e34ac@gandalf.local.home>
In-Reply-To: <20260325153826.EbSqlX_n@linutronix.de>
References: <20260325030508.321405-1-jiayuan.chen@linux.dev>
	<20260325111351.1d38a0bc@gandalf.local.home>
	<20260325153826.EbSqlX_n@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 5062B2002A
X-Stat-Signature: s971ewtf1ruyohesayz51yj7bhbo934u
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+bMK/bjfJmQKGzL2S5Oc57xZTBTTlMT38=
X-HE-Tag: 1774453951-217828
X-HE-Meta: U2FsdGVkX1/PecGsXuhih8cr3+Zo3T/ozg+cHogz9PzRNYI+Guoxmd2nueso0cxgSA3/1nlnx3ZKpLA1z0c2buPcqnyvL+BUX4Xn0Gmq1tqXlCG9kafrDrCGlH0vIcK2V8F7bpv6tIrNYP/21FXnIEJRQf53ONMtnXB3tmZj4xCWM9MqxdtdljGqJ39GsjgmMDYMV2cxtUGbiZZTZsJBfqSPBrqK/TWF6LdcuL+uQQ2l8Ml7X206zlECkPDZ9X0eH8M1Rs6NhBxI9edU+3/u1y070LP8FnLQpw5t52JGGbBMDPiGYpvBmZkAMGOskIju

On Wed, 25 Mar 2026 16:38:26 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Most irq-work aren't free()ed since they are static and remain around.
> There is no task assigned if there is no active waiter.
> Wouldn't it be easier to kfree_rcu() the struct using the irq-work?

I guess we should add some kind of helper then. Like tracepoints have.

   tracepoint_synchronize_unregister()

Perhaps have a:

   irq_work_synchronize_free();

Or something like that to let developers know that they just can't safely free a
structure that contains an irq_work?

-- Steve

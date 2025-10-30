Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461312E7167
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Oct 2025 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761818695; cv=none; b=jGKvdsX6yFHDPqrI0yMlVFuizHlInYr/6QZCYkjX5oclVoWeE4BAyebhpQFcG2hf9flcZljIHD0VV8EAp+X/WTZmKqWl4ULhtUyTiJElfBw6gmsNDw5dkgMaStIFnj+u5mqaSmyR4AnyiVpplT05ZdHP3WFpvHMrq8O7tBvQ/mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761818695; c=relaxed/simple;
	bh=ub2t8qaRjNYklwzLwIkQR2fSc5ymCCWaqGt974gj4lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YCwv/DDQ7oxq3erJtBrkWgf+fhjqmDON83n8wUgMma8beIkxAXcb1Fvyo3/pBJr23KEUIStl19XXbpXEJeSSjUl4jU/TrvZ3OUIUQrM+wiGRtengjco6FmUUjlzt5xhGhq6CZF2PARAgW762ytv/l28edoW1ShnFTzWZLQ8SrA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 81F9C5C43A;
	Thu, 30 Oct 2025 10:04:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 824162000E;
	Thu, 30 Oct 2025 10:04:49 +0000 (UTC)
Date: Thu, 30 Oct 2025 06:05:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Xie Yuanbin <xieyuanbin1@huawei.com>, arnd@arndb.de,
 linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev,
 linux@armlinux.org.uk, tglx@linutronix.de
Subject: Re: [PATCH 4/5] ARM: Disable jump-label on PREEMPT_RT.
Message-ID: <20251030060531.505d7127@gandalf.local.home>
In-Reply-To: <20251030095615.ae7bck5m@linutronix.de>
References: <20251030072339.63vdFNo3@linutronix.de>
	<20251030074507.33863-1-xieyuanbin1@huawei.com>
	<20251030075558.sUBj8_6U@linutronix.de>
	<20251030054626.7a897b29@gandalf.local.home>
	<20251030095615.ae7bck5m@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 824162000E
X-Stat-Signature: 4tct77647hn1ouygiy1cqijmkym88pg7
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18xIVP8FdiENPwAdW2uZaQx4Hxlw9FUnNI=
X-HE-Tag: 1761818689-72234
X-HE-Meta: U2FsdGVkX18fud/O/dYe6YxVvNIhorpVgtqv6mOR4YADnRseWGVNwbjKe16X1uEPx0Lqjwaa6pGPMORofpmI5QdXygEaFdHMZPlRlGG4SQOxQASEgOpjE59aFU0G6roTb0lSMr2VPfwCexIfZj/cmz9dYNFA/tjtTAyua3jEhLWIgPU+OorOcPt6c8Vrk4hDWPHVHpJpH0Mn7jc2wGUftm+1TbeblI7jgZRMy+VBl9fkI6z8Xvp92cHW7Tpf+L1keh+TjK0vzCZADKWKT076sCSrynHqvoUWhxN39pTfEya2voktzvfamey8coPSyzeg

On Thu, 30 Oct 2025 10:56:15 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> trace events were an example and this is used to enable tracing in
> production or development to gather information if something is not
> working right _or_ on the edge to investigate. A latency spike at this
> point would be a timing violation forcing the system into a safe state
> an so not allowing further investigations.
> 
> I hope I made it clear that using jump-labels at this point is not
> doable at this point and a warning does not improve things. Improving
> the implementation on ARM as it has been done on ARM64 or X86 is how I
> would compare the situation to printk. Not adding a warning at boot
> time.

I wasn't talking about the print being at boot time. But when it gets
enabled (like when RT throttling happened). I wouldn't even do it the first
time it gets enabled, but print a waring when it is activated if the last
time it printed a warning was over a minute ago. Thus, even if it was
already printed, but it didn't cause any noticeable latency, it would print
again when it does.

Thus, if the system goes into a "safe state", it is obvious from the logs
it was caused by a user interaction.

-- Steve

Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D2EEEC0
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Feb 2026 00:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771549139; cv=none; b=X7axCpsHNQVgOEyFbFq6ATAqGi81l6Gb3PI+8atrAD1J1+fK+LF6O53Zb5kYCPH/yEWNPFSghGFp02tSOxS2CYfiSP7TLk9k66EKJyQS47gpkh2IpVRRrtnSx8SlrhbNMp9S4JO2GuawIjNV/g4IYn9eVQZimypvuoLR86sn6RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771549139; c=relaxed/simple;
	bh=UFH4lrbC1VTdGZd5zenCvTkE0T5ChLTNbZHsoOfzF8c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJNEaEmeqjFq0WAuPHbA8w5+CDSPvakFW1dbkjHMB4Gy1QVByYC4p4qCeShCKF0u23VpG+8iumQYGGrgW6B6oflUQt2DFEYZLT7uNPAYVXeC3Iu/0O3KKOndTsbCgMmBzOpKuZyW+PeQHzDJttzyF1vi1KHuRas3jPEBFTBHqug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id E5A1A5B8B3;
	Fri, 20 Feb 2026 00:58:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id A510720024;
	Fri, 20 Feb 2026 00:58:52 +0000 (UTC)
Date: Thu, 19 Feb 2026 19:58:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Calvin Owens <calvin@wbinvd.org>, Tejun Heo <tj@kernel.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
 <tglx@linutronix.de>, dschatzberg@meta.com, peterz@infradead.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: ~90s reboot delay with v6.19 and PREEMPT_RT
Message-ID: <20260219195851.7a7bd1b2@fedora>
In-Reply-To: <594b9094ab76acf9e73cad8fca9c9efd6f75a980.camel@web.de>
References: <aQufmyZ7X7NdfiCL@slm.duckdns.org>
	<20260219164648.3014-1-spasswolf@web.de>
	<aZd4YCNTAHZNpTfh@mozart.vkv.me>
	<594b9094ab76acf9e73cad8fca9c9efd6f75a980.camel@web.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A510720024
X-Stat-Signature: 3bfa1bospgc7poxemdmgqty4g91j61bk
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/WD4PsYpJ1g4Ti3mgiXee7gMa7zglwKHQ=
X-HE-Tag: 1771549132-630394
X-HE-Meta: U2FsdGVkX184VuH0m5zSwdomenAlwFd6/YfNzyJhmYx0nFCIChw8aQtRTwjbVnRvoE+8SSeHKh2guHeW3UE+id97AOq23WlIFX21LLMxGNUEyq+U8PtJI2+LmhvyIvHGWoxw47pd8EZKmAUyEX6kaUNM8XDarac4nW3oSxbLbeQmPjCXpw0fw2YeN86DoRb6d9+pj0hTyBO9ZsTJrkEXv7C1zn2KOhk8xWy2gUJ/5tiBiIeFNYvqzVK+5g3nbVsndYamdd/cOfkK1LxV4J2inj5QD+rDpfdR6a9xvmrWYk4IxWh/ewGW/tRwpfPy6Lr5

On Fri, 20 Feb 2026 00:10:41 +0100
Bert Karwatzki <spasswolf@web.de> wrote:

> These seem to be the same type of messages that commit
> 9311e6c29b34 ("cgroup: Fix sleeping from invalid context warning on PREEMPT_RT")
> is supposed to fix.
> When I compile a kernel with 9311e6c29b34 as HEAD I do not get these messages, so
> I guess I have to do another bisection here.

Can you add to the kernel command line:

 trace_event=sched_switch traceoff_after_boot

And then look at /sys/kernel/tracing/trace

It will enable sched_switch event and the traceoff_after_boot will
disable tracing right before running init. That way you can see what is
running during boot that is taking the 90 seconds.

-- Steve

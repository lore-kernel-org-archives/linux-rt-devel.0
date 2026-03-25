Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD5940627D
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Mar 2026 17:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774460634; cv=none; b=jKd9G/kdnD6+hT7OMEWzQwm/0yLWeTdUTuKmJ5DyBrkVNzxjoZFS4oHycL64wr/sl5Q7cBDgzwW7GsqcNKwQfUkLfkZJAS9K9tAAegLNTU+auFYARdaInWAv34I6niVhfvrlf3I/Mzqp+V+F4+eEkQp1nXS2a3VuAB/ll4T6UdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774460634; c=relaxed/simple;
	bh=ABdnxvJrLXIyqtBD2+XtQ/hPq2DwqVVUrdozkPzvrqg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sef8O4HtkVGg5Bq2nWSC7i35Z1adzrNEdeh1/LpvZj3yxi0rUdqADtvZoZv3txZD1jBiHXlX6zZahPd3wugMvGrP0n3GnUGX6MtNEXZU/2wUBBRMlQscASm77fJcAQNiLpoiGXg7qEi8OxSyjzsofzcchyiSogm0VoeBYHDdwOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id D28DD5B791;
	Wed, 25 Mar 2026 17:43:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 078DD17;
	Wed, 25 Mar 2026 17:43:48 +0000 (UTC)
Date: Wed, 25 Mar 2026 13:44:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rt-devel@lists.linux.dev,
 Clark Williams <clrkwllms@kernel.org>, linux-kernel@vger.kernel.org, "Paul
 E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v1] irq_work: Fix use-after-free in irq_work_single on
 PREEMPT_RT
Message-ID: <20260325134433.7d46507d@gandalf.local.home>
In-Reply-To: <20260325170539.MHkr49jU@linutronix.de>
References: <20260325030508.321405-1-jiayuan.chen@linux.dev>
	<20260325111351.1d38a0bc@gandalf.local.home>
	<20260325153826.EbSqlX_n@linutronix.de>
	<20260325115315.052e34ac@gandalf.local.home>
	<20260325155504.tm4zHWMI@linutronix.de>
	<5b6f6480-aa2d-4966-b3c7-6c719e915285@linux.dev>
	<20260325170539.MHkr49jU@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: qiakmkmbtjrpdnuxr7at5ubwkppcer8b
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 078DD17
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX188j2HV6DzMYPqJOtQU0fgnQnkmc/utOtc=
X-HE-Tag: 1774460628-368407
X-HE-Meta: U2FsdGVkX1+WJQCw4KJe1rZXF5reKf8O5A48UUZxO8XarKMD2Tjk/p2TobYKXWLDeALj92mgbq9aKgue3virLkpA2sZbS24/iwc2LVEJcmV3mZeqjGlYD+LIOsv5ptpu2jinvVF6DjLmwgdDArfkO1sF1vmZyP0MkEAGB06NwKWKJxCvWXty2uu80hCdHMUK6deFWpmPB7ooX9gMSvysVGYjLbJ4Sj4MjZ9yuMhMv2TxZQ4YZgD57qyH6juKvbzqxm+MAzDfg7WeTpo1KINy29PHGOlRYMDnu/mWeI5GodRTJGTCLOLzVC80BrSQG4Hm

On Wed, 25 Mar 2026 18:05:39 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Why not just having the synchronize_rcu()?
> 
> > Callers that free the containing structure would switch to
> > irq_work_synchronize_free(), or use kfree_rcu() if appropriate  
> 
> If we provide the irq_work_synchronize_free() then using kfree_rcu()
> would sort of open code irq_work_synchronize_free() since we couldn't
> simply replace synchronize_rcu() with something else and update the
> irq_work core side (we would also have to update all users). I guess
> that was Steven's idea in providing a helper for synchronisation.
> 

Yeah, the helper was just document that free work needs synchronization.

Perhaps Jiayuan's idea is better as it will not require modifying current
callers and does fix the issue.

But it would still need helper functions from RCU as I really do not think
it's a good idea to open code the rcuwait logic.

-- Steve


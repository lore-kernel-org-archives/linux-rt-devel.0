Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9BCA937
	for <linux-rt-devel@lists.linux.dev>; Fri, 26 Dec 2025 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766764982; cv=none; b=iUViolOwQPysniJmMO8e695mFCaxwQWpR8ZGBMEooLoqPTkIhvWMIIsDB2lKlTokartDbVVoHflvJcSCmEB9c64yiHKR3wtV1iTprwKS/gKZyDIqm957SC4b+RJhxFC00hRe/8G76f7g7MFFVfgLXHy9E37IeRTVVfogZkgN+ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766764982; c=relaxed/simple;
	bh=BIOrZ3q7R08cNltIPmA+0z3+IN5IxCLYmB2KPu12120=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=N0sZKHA480HZ/QD6Twa7dMV5OU/3sJO+OUqLBGkTp3RFwD6+udgg41DwW1yZt6s2JkO5H50doWvn+juCERJaO2PX/dGxiJvIAp/JynBGL7qf5zLlXdHtMy3UQAIvkzXG9PvAkgYGZR/G7EM4Gyeo9NNsRWL4OGIbrFjAPy/i85E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 209CC8D0EA;
	Fri, 26 Dec 2025 16:02:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 7F4D920026;
	Fri, 26 Dec 2025 16:02:51 +0000 (UTC)
Date: Fri, 26 Dec 2025 11:02:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, liangjlee@google.com
Subject: Regression in performance when using PREEMPT_RT
Message-ID: <20251226110249.0c2f1d8d@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5iojb77gqd99fqam9ujz6jgqdcczpqth
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 7F4D920026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19g/oDC/7wy7nOHJYzm3uVipgAPSedGnuw=
X-HE-Tag: 1766764971-713396
X-HE-Meta: U2FsdGVkX1/PYAL5kBdOeEomb4I1spK3YUE0zLOph0jrQrDYSeM/4awQRBGajr9aUZbXk5zgAh2tnrtNbT2DSv5pJ3aMJF8SoScuwO7cBVAUlMOdJayTIuwSxledOHHEh6rIiztvgZRp+oQjLyWHW0XKF92dAImSRbzlwxRwR86wnFqK83BGK3uN/wOi80rag2kqQX9nQJ40+O5Ac7VUrqznQ0iGPwgkMqTvm3VA3iJh4ciijW+td0I9Rbk7pfu77YfsbE1hZmHRx+3ZtzQ6cKdAzXpKP9mAnz/uEQf5Q4lI41yCLwTddUA9PpMDfI2B

Hi Sebastian,

We are doing some experiments in running Android Pixel with a PREEMPT_RT
kernel, we found a few unacceptable performance regressions. One was in the
block layer. In non-rt, the ufshcd interrupt would trigger the BLOCK
softirq on another CPU. In RT, it always triggered the softirq on the same
CPU as the interrupt. As the interrupt line always triggers on CPU0, it
forces the BLOCK softirq to also always run on CPU 0, which is bad because
CPU 0 is a little core and the main work should be running on a big core.

In block/blk-mq.c:blk_mq_complete_need_ipi() there's this code:

	/*
	 * With force threaded interrupts enabled, raising softirq from an SMP
	 * function call will always result in waking the ksoftirqd thread.
	 * This is probably worse than completing the request on a different
	 * cache domain.
	 */
	if (force_irqthreads())
		return false;

When I saw "probably worse", I'm thinking this was decided by analysis and
not by any real numbers. Was it?

When we commented out the above if statement so that it did not return
false, things sped up to almost non-rt speeds again.

The fio benchmark went from 76MB to 94MB (higher is better). It's still not
at the level of non-rt, but this was definitely one of the areas that
caused the regression.

Is that exit out of the function truly needed?

Thanks,

-- Steve

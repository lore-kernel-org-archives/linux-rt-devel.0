Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA9030FC3A
	for <linux-rt-devel@lists.linux.dev>; Thu, 18 Sep 2025 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210582; cv=none; b=AxMlwghOQwmFnuL51iIgo3Hm3+CEKrgTlnnN9qOPBP8AqmZXPsavArECwMpHEmT/VXLzTPLwyn0sVdrsxatxuXb6W9yZ/XjHaSXGUKYfTQMIlvmiITYWiIAYiD7BC54MajZLDfq4pdd7TVjE3X02xVclyfcY3ypGF0jsyF9wWEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210582; c=relaxed/simple;
	bh=Tu3hQmIplag6Boj37rOZRIxg+q0RX8nAwgJMMdLlaqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUh7gZzheKFevA+i6iMYFOMe3Ry1Mcu1YlXgbn7taAXELmAMxvXnQN7JMYqJFPn49KZdSzuXSENsl0JVXW2c5LKiDohHmsZrWhiMo6fzV90W5asD3yTwK9BrYLw8nOX8lxQvCMxX1EF6INo7tHoiSGr0akMqAzGQ1h76OGBDiKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YAf5jvzH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j7VBlfql; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YAf5jvzH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j7VBlfql"
Date: Thu, 18 Sep 2025 17:49:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758210578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cmvTuuz6y83mxY1NenzRoJM8fQybFqPitezBXCcZxWI=;
	b=YAf5jvzHjpFNeJIpII5+JOB0lqoLy501EnRxXWEnySIMsDkbOxtZuir0rHD7+npu15njWK
	T843wDkG+Hsq6TohJ2QbYfN+7f1nX1y0ozFLJ7XFcZ0EZQrmJB45lrG0f8VuEHrmYHtyjb
	M//nkcH228fZL/g3hopQVBiTgqKlxHI33uI64Zi+Ya7GVd1O5yFaQayGKIEGeRt0xQN+oQ
	hJ5WabTPG3K06y+5O7j0PFDhIuuRl5PTOq5JXnfVjTSSOvH5wCAV1MChU6fkF6pGUR1Jc5
	pVaNqHVkWd5uhW3EOK+4wiz/vt6BN2zZbMf3QGhLlSl8jmhM/nCWwv8u4Z4OBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758210578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cmvTuuz6y83mxY1NenzRoJM8fQybFqPitezBXCcZxWI=;
	b=j7VBlfqlasNpWNGrU6gu9/tS7qbT5SOLbXS9XpbyJfuTyJCaJhGEMIeN1CavzqhvZDYsxZ
	AMlZlg6ZXGRZqMCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Hillf Danton <hdanton@sina.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 2/3] softirq: Provide a handshake for canceling
 tasklets via polling
Message-ID: <20250918154937.RQqkeYxI@linutronix.de>
References: <20250915073933.L7UOtfkj@linutronix.de>
 <20250918134753.7122-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250918134753.7122-1-hdanton@sina.com>

On 2025-09-18 21:47:52 [+0800], Hillf Danton wrote:
> On Mon, 15 Sep 2025 09:39:33 +0200 Sebastian Andrzej Siewior wrote:
> >On 2025-09-05 18:15:01 [+0800], Hillf Danton wrote:
> >> 	CPU0			CPU1
> >> 	----			----
> >> 	lock A
> >> 				tasklet C callback
> >> 				lock A
> >> 	cancel tasklet B
> >> 	DEADLOCK-01
> >> 
> >> After this work could DEADLOCK-01 be triggered, given no chance for DEADLOCK-02 ?
> >> 
> >> 	CPU2			CPU3
> >> 	----			----
> >> 	lock A
> >> 				timer C callback
> >> 				lock A
> >> 	timer_delete_sync(timer B)
> >> 	DEADLOCK-02
> >
> > You are not supposed to acquire the lock, that is also acquired in the
> > callback, while canceling the timer/ tasklet.
> > Tell me please, how is this relevant?
> > 
> > If lock A is acquired on CPU0/ 2 then tasklet/ timer on CPU1/ 3 can't
> > make progress. Now CPU0/ 2 waits for the callback to complete. This
> > deadlocks as of today regardless of PREEMPT_RT and this change.
> > 
> In case of !RT, the chance for DEADLOCK-02 is zero because deadlock is
> detected based on per-timer instead of per-cpu.

But your "lock A" is global, isn't it?

> > The difference is that !RT requires two CPU for this to happen while RT
> > is efficient and can trigger this with just one CPU.
> 
> In case of RT OTOH, false positive deadlock could be triggered because
> canceling taskletB has nothing to do with the callback of taskletC.
> 
> In short I am highlighting the gap between per-timer/tasklet and per-cpu.

I don't see a problem here.

Sebastian

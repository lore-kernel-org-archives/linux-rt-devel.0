Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF23E271829
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739381575; cv=none; b=OAXq3lq2pqUIkGAgxiquyQNAnFluFQVJsJnz96WSvyLu5YsQB83JwsQ4nwO6XGeK0ZhtKondyBZTOfrqvWkTRQSL8uAcv8rRQZVYJ955N0EOsOnCAT3oyPKeYITeO6ptLfyAuexJAga9hiHvB8baJ699d7UeIwtiQDPIkxqfDZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739381575; c=relaxed/simple;
	bh=94yVLQZnk+EqdpTh/OT5CTAKFKisUcvUpW6SfMsW2hY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XnS9La5vAKA9+4wVk14uGHM1KevcZAFQ/zTbXYUDZKXqJN0Vw4QrX0P80ZTSpz0SGZEPOjaIr/VyCjFDfzaXGSW6NHK06Tz31OiFIDnBu3CmbNW3FXCf5WGZ9JacGa8xp/6djPtc8VcSdUv8k03/liaRSlxaI8IfiHRmMILd+Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943DDC4CEDF;
	Wed, 12 Feb 2025 17:32:54 +0000 (UTC)
Date: Wed, 12 Feb 2025 12:33:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Guenter Roeck <linux@roeck-us.net>, Clark Williams
 <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev, Thomas Gleixner
 <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: possible circular locking dependency backtrace seen when
 enabling PREEMPT_RT
Message-ID: <20250212123302.0f620f23@gandalf.local.home>
In-Reply-To: <20250212172417.DQF_YTTy@linutronix.de>
References: <d9480845-7e81-46a2-8bbd-bd0ebdbc6a5f@roeck-us.net>
	<20250212114531.4e95ffe7@gandalf.local.home>
	<20250212165908.DoNnHJ5v@linutronix.de>
	<20250212120328.28fe4123@gandalf.local.home>
	<20250212170955.x1oRhNjr@linutronix.de>
	<20250212121837.3b25b941@gandalf.local.home>
	<20250212172417.DQF_YTTy@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 18:24:17 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> > That would keep the same paradigm between non-PREEMPT_RT as well as
> > PREEMPT_RT without having to litter these all over the place.  
> 
> I am working on getting rid of the lock in local_bh_disable(). Guess
> what happens then in terms of "same paradigm".

No idea.

When you disable interrupts in non PREEMPT_RT, it also disables the softirqs for
that CPU. Thus a spin_lock_irq*() by definition will disable the softirqs too.

I guess it also comes down to how many places this happens. If it's not
that common, then perhaps this is the simplest solution. I just don't want
this to become the new cond_resched(), where we have to sprinkle
local_bh_disable() around to solve issues that are reported here and there.

-- Steve

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4112126156E
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 18:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384215; cv=none; b=D1fGxplpLGgX+88SUtu4mYAfTATgkubsQ8mQVPXPepovHSD1kA1W4NeK8/xuf8OCXbSyf+tlg2Cbw4FcyeRBInB03pZ7yqtfGqsMIcH5ZIfeLn1635nHBSc78TIYKAANQmekCTUeOwOenbCkl2IcDA/l/nmDBNCPxpo2tT5ARoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384215; c=relaxed/simple;
	bh=s+aBdJceLKWvAU60g5ui5Xbmwxoa37WvpcWDuGxbL3s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fdDIrXF4ceyM0rvLuT05ruRc1NEg9lXtEefP+siK6Q465c6s1P+LHSQv2HxqqDUjusw/P2aDwftd4l7VZLza/3u7ngD+Cf4LYhpVCz5BVPRfLiK8soUjSExqyyhv+alBIDd4EDfNQCSv8Loem6auCDLZckGRy0WmCSvfS5GeFuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58570C4CEE4;
	Wed, 12 Feb 2025 18:16:54 +0000 (UTC)
Date: Wed, 12 Feb 2025 13:17:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev, Thomas Gleixner
 <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: possible circular locking dependency backtrace seen when
 enabling PREEMPT_RT
Message-ID: <20250212131701.28ca7f90@gandalf.local.home>
In-Reply-To: <49075164-c44b-4921-b422-dd336ce14e79@roeck-us.net>
References: <d9480845-7e81-46a2-8bbd-bd0ebdbc6a5f@roeck-us.net>
	<20250212114531.4e95ffe7@gandalf.local.home>
	<49075164-c44b-4921-b422-dd336ce14e79@roeck-us.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 09:54:20 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> > Can you test that patch to see if it stops this lockdep splat?
> >   
> 
> That results in a variety of interesting warning backtraces and crashes :-).

I said I didn't test it ;-) It also had a bug where I put the
local_bh_enable() in the wrong function. But that doesn't matter, there's
other issues with it.

Could you try Sebastian's version instead.

Thanks,

-- Steve

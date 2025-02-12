Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4F1212B31
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379801; cv=none; b=txgvfqVskPuoZIelXNlLwtoMJf1s7ji4/llRa6efegjABsf+JroQqNl+VeNvYuIcbOTmzpyGARWyDTbL0EusTZySrcxcT7o2jdgZC+lMC+ytYYs4XVKC04/a8DUi8OkbccEwoaJ0+6rD5ZfQcevN7L1yx1bC6q8UBLFYl6d9W8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379801; c=relaxed/simple;
	bh=Mzkmywf8M1Aye90iTslBCwZivOy97dvUIhNmY3cNGxY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YoEHYFSzLibTzRmKixx+8TOIzs+XCwtDLvPG49hrTZ397Yp/FyLgu9PPRRS2lAJxNWSvMhKjVkBqoUhYTPUWxqdONuiaawnbDiUcTcNRQ56WLhQdRv4dxoBVdAUkTg6CfApe8YOqovggdQFfLEC7tn0rNmVWSoGad+37z4NOozQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B408CC4CEDF;
	Wed, 12 Feb 2025 17:03:20 +0000 (UTC)
Date: Wed, 12 Feb 2025 12:03:28 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Guenter Roeck <linux@roeck-us.net>, Clark Williams
 <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev, Thomas Gleixner
 <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: possible circular locking dependency backtrace seen when
 enabling PREEMPT_RT
Message-ID: <20250212120328.28fe4123@gandalf.local.home>
In-Reply-To: <20250212165908.DoNnHJ5v@linutronix.de>
References: <d9480845-7e81-46a2-8bbd-bd0ebdbc6a5f@roeck-us.net>
	<20250212114531.4e95ffe7@gandalf.local.home>
	<20250212165908.DoNnHJ5v@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 17:59:08 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2025-02-12 11:45:31 [-0500], Steven Rostedt wrote:
> > 
> > Shouldn't the spin_lock_irq*() variants for PREEMPT_RT also disable local_bh?  
> 
> Better not. The consequences sure wouldn't be funny.
> 

Why not? It keeps the same paradigm as non PREEMPT_RT. Do we really want to
litter local_bh_disable around all these cases that spin_lock_irq*() is
used to disable bh?

-- Steve

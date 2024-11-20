Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4F71BC9F5
	for <linux-rt-devel@lists.linux.dev>; Wed, 20 Nov 2024 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732115615; cv=none; b=oLP1JCxuifAiyY6rkulufu/fza98GtfAeqtHqgnHfd744EgWdFMcm/C3qew3ctuBk5m7RoDzUc9Qwm8xNRLx/nUh8mSUWNfwXx+5Ev5+T4IvqokJnmDx9QULJdAcuumpVi5p6Tk0HuJ/Z1yfGh0m7Z+/0II1qEJ5gKOUz73gdWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732115615; c=relaxed/simple;
	bh=qKv9cxbSY+Qe8be9WuTZQY3IxWhec3ATul1vGb9cfs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PE3Ix2rR2edOUBKHP/1Y5uCnjgDPPSWG0C7t76hvdyZxtCtuXxreDUl05d86UUpzB5pk6j2pIK/HjIWRsq9RyD8iVAevPxSm0H/vL+g7Ha+euLCwKcouWPhJFs4FT3prBcGRud1n1jZEU9dV3ydBoXIxIkcwLfnjp2UDhJmkTWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uMZdtdQ+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EoHW11c0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uMZdtdQ+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EoHW11c0"
Date: Wed, 20 Nov 2024 16:13:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732115611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EyO8yv8V4ueZfLiOBMizzmpe+ea8iyO25drixQuoPIY=;
	b=uMZdtdQ+edsln1z1OlicaONMvdN6iaesn6y5qYMjSZI7zi0tDxUL0YBV7ddareJwzQI/KR
	AvLUM75RMybwKoeCNOiAHLYEyqYErHxfTYRuo4S6eCCWT33N5dj3BeMYptcDeXd0RQL4w8
	zxtS6gcUUd/ingmnljT+0NIlDDp2SkBcW9HdNTnZEmFQBTOyS8A/72IYiuAo9qva+TKKrR
	e4hGBeNNpLi29j11uiCVoOme1HZtkBCMmzFO9GfW7vUTyXiG+YBiUZ3TsfRKrkM1IDTIKI
	QH/ex2DWgFdIKv2mM5yde+YErwNjC9aXvQKU6Md1kCJ7zldXcJMKE0KdViN+cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732115611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EyO8yv8V4ueZfLiOBMizzmpe+ea8iyO25drixQuoPIY=;
	b=EoHW11c0n63ekpk9SHmSTus4WuhhFTe/zue9FX/KIpRWzURrr0p2m0qeLAokfkGLfcTcwb
	W5f5t2S9QTMY5LDg==
From: Thomas Weissschuh <thomas.weissschuh@linutronix.de>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Alessandro Carminati <acarmina@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alessandro Carminati <alessandro.carminati@gmail.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Gabriele Paoloni <gpaoloni@redhat.com>, Eric Chanudet <echanude@redhat.com>
Subject: Re: [PATCH] mm/kmemleak: Fix sleeping function called from invalid
 context in kmemleak_seq_show
Message-ID: <20241120160448-11661c83-6a2e-4afb-9711-ffec3f9342b5@linutronix.de>
References: <20241120102325.3538-1-acarmina@redhat.com>
 <Zz332cG45rNSeE_B@arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz332cG45rNSeE_B@arm.com>

On Wed, Nov 20, 2024 at 02:53:13PM +0000, Catalin Marinas wrote:
> On Wed, Nov 20, 2024 at 10:23:25AM +0000, Alessandro Carminati wrote:
> > This patch addresses a bug in the RT variant of the kernel where a
> > "sleeping function called from invalid context" warning may occur in
> > kmemleak_seq_show under specific conditions:
> > - CONFIG_PREEMPT_RT=y
> > - SELinux is the LSM for the system
> > - `kptr_restrict` is set to 1.
> > - The kmemleak buffer contains at least one item.
> > 
> > Commit 8c96f1bc6fc49c724c4cdd22d3e99260263b7384 ("mm/kmemleak: turn
> > kmemleak_lock and object->lock to raw_spinlock_t") introduced a change
> > where kmemleak_seq_show is executed in atomic context within the RT kernel.
> > However, the SELinux capability check within this function flow still
> > relies on regular spinlocks, leading to potential race conditions that
> > trigger the error when printing the kmemleak backtrace.
> > 
> > To resolve this, the backtrace printing has been moved out of the critical
> > section.

[..]

> What I don't fully understand - is this a problem with any seq_printf()
> or just the backtrace pointers from the stack depot that trigger this
> issue? I guess it's something to do with restricted pointers but I'm not
> familiar with the PREEMPT_RT concepts. It would be good to explain,
> ideally both in the commit log and a comment in the code, why we only
> need to do this for the stack dump.

Yes, this is a problem for all users of lib/vsprintf.c.
I am working on a fix for this, to avoid calling the sleeping functions
from contexts which are not allowed to do so.
In these cases the pointers would not be printed.

This fix for kmemleak is still needed as the pointers in the kmemleak
report are useful.


Thomas

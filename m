Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AADA188006
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Jan 2025 07:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738221873; cv=none; b=D4U8+c0NJuIajvxE7rCiqbyNmTUdn35jHdI4wI+dy0rg0Fg33mOzmopPNr0zJome8kCJUULC/nWO6QjZqrt0sMGpQ/et/oFCv0GPKKNMHWCr2BJBZBBfWysAW2oorsIvSbWYZB7gnwSTmjQzkZ1/JiQdR85Kst3acc7sfpLVMY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738221873; c=relaxed/simple;
	bh=EPRi1PZ01B954G23dxbaIvbyjxv6VV7OvewloRYel8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quyOHZiTOyJ+07pYWHT7JMHcHtqEs/DZUYO3NSivTcn0/SB33uz2Ro5uMEWms0gaEt9FoWkWM00I+dqx00Oc6ooA7qLt3ip2Q/VXBuhNAFlLSphvvR571KpvvQ3TVVmVNPOWKAqd8L8myOpsxVOlpJv7HTixPJSqvT/6bXBokzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X0Bj1ocB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dIYv1HUH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X0Bj1ocB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dIYv1HUH"
Date: Thu, 30 Jan 2025 08:24:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738221870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pMDIP5Gw6qFAZGvmnilj/v5Bwf6V8vvxq9BnwnjWizA=;
	b=X0Bj1ocBsnOEPhk3r20oo3qJXpp/9aOIyHuSSVmbtYrNkbkh+MmnBUj5wQ6FyDJMOHyX7L
	pKi7O4Kb+czTLeb0Fu3IgNoKEjvGRYvcqok/3zxB0gcEOXve3MmPeG2tsOgm3+EXPk3MQ9
	19EnNF99ix5Inmy1wyclzJ5P4PFZlhIZN5HOB0RC4f7ICAeh/W53YOycSVIPJ4EPoMMRqH
	ADCdDqS5rH85/S2VrozUFnekqI3MVMNcwVnHDyNTYLy/tP4R6vgK9Z8l9gri+f6kW8Oiof
	lcmiQfaNPA0tWFTsFKr56Xox9K+Uptsh/dlkZnfNjJpMCu8Ga2ZkCO9vBQc7oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738221870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pMDIP5Gw6qFAZGvmnilj/v5Bwf6V8vvxq9BnwnjWizA=;
	b=dIYv1HUHf5IVw/vFekseaKR4+CK1wjsMyYkOeMg7OZ9Moo6QF8it5RKIPbkVrb0M8PNG74
	YQ5AXUAIQYc4DmCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Waiman Long <longman@redhat.com>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, Feng Tang <feng.tang@intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v3 1/2] clocksource: Use pr_info() for "Checking
 clocksource synchronization" message
Message-ID: <20250130072428.tDDW2DKs@linutronix.de>
References: <20250129224001.430506-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250129224001.430506-1-longman@redhat.com>

On 2025-01-29 17:40:00 [-0500], Waiman Long wrote:
> The "Checking clocksource synchronization" message is normally printed
> when clocksource_verify_percpu() is called for a given clocksource if
> both the CLOCK_SOURCE_UNSTABLE and CLOCK_SOURCE_VERIFY_PERCPU flags
> are set. It is an informational message and so pr_info() should be used
> instead of pr_warn().
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: John Stultz <jstultz@google.com>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

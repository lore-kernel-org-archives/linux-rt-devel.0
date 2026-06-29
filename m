Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924F334D4D6
	for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 07:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782719851; cv=none; b=YuWD0q75WGdhO16FyU17jseAQExrudcAH+xbF0Ry7JtY6JHlAyrw1h3Std9PZT90xoLpWpyf8txk2nXWtY9Nvqx2vZ7yiI73TonsA6pXEkuw76oqYTKI+b5NBkF+3odZGFGv4oFEVkT0QGymMkHJ1P0F9oXJg69Bm/SGCOihYIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782719851; c=relaxed/simple;
	bh=OnpoeLGvPlHcPYQIpHF6VX24vKq+nhYSwXyhH6lBRcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqk0TGtCutbhkkwAQUPGNWtn7QxWvKnLwLSXlcpGTsafoG1zGhE0XVWsdwqoKPCx3MWKeBm4z7+g+T/Wq8hAziClklBnrbv2Xfa0QAV2bnUZ4RtxBRKuMl8tcx5RxdAaXrcxKXEy1b++M4VrSRD3aWdYS8hyNKcaxA6lYSGof9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0KCCmphd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vzYv0Six; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0KCCmphd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vzYv0Six"
Date: Mon, 29 Jun 2026 09:57:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782719848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r78oSdhTVN+8MeD5ByYXQ1b1CKPj92ZjAEWWw6Wo7CI=;
	b=0KCCmphd0bIumHVx1JyMEzRPcI71wGxWRC5J2cPJR+lS73V+fDAEr2hbzOD2G/1YM1om+5
	JL5dlY6/pdSP1zEiKFRnOefG58e4Q+a19/55EnwwFkq9L9G2JGayB83gSYkFqo/R7SJbfG
	2Oz7NNJvU2UQ4VUXrZ2u1d5FwVctDWmbXvO66s2Udoi2uGrxcgHrRLWG5uhDhlPeXtKdDJ
	dqwmnXwze5+9tYWgDUdBNstfQMvgbtNvsgyJN8yMVDtwOPr7CGD3/94cP0N8xP2CzmIgRY
	zEA9RI1zcSa/jbcI2gL7TbPCwGncfETsjfTjznC1INKzEhqkgz9F6LyutreuuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782719848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r78oSdhTVN+8MeD5ByYXQ1b1CKPj92ZjAEWWw6Wo7CI=;
	b=vzYv0SixowAx7/+6dSEJ2TBOFIkr8EAYnDXfSACWBfoqPSMggio8VWRUqcDgG+UvyKdOgL
	xaWesL/6nElCsLCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk, clrkwllms@kernel.org,
	rostedt@goodmis.org, linusw@kernel.org, arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, liaohua4@huawei.com,
	lilinjie8@huawei.com
Subject: Re: [PATCH] ARM: enable interrupts when arm_notify_die() is handling
 user mode errors
Message-ID: <20260629075726.McX9yWi1@linutronix.de>
References: <20260625152159.WtO_S3i7@linutronix.de>
 <20260626082953.47503-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260626082953.47503-1-xieyuanbin1@huawei.com>

On 2026-06-26 16:29:53 [+0800], Xie Yuanbin wrote:
> My personal view is as follows: First, an Unhandled kernel fault indicates
> that the kernel has encountered an error, which is different from an
> Unhandled user fault. An Unhandled user fault can be artificially
> constructed by user programs, whereas a healthy kernel, in theory, should
> not trigger an Unhandled kernel fault.

correct. 

> When a kernel has already encountered a fault, I think that printing fault
> information is more meaningful than improving the kernel's real-time
> performance. Imagine this: The interrupts enable here, and at the same
> time an interrupt arrives, and then another kernel error is triggered
> within the interrupt context. The log would be a disaster.

The problem is actually hitting that "error" spot before oops_enter().
In oops_enter() not only interrupts are disabled but also the emergency
mode of the console is enabled. That means all console output is written
via the atomic_write interface to the console as it the output happens.
At this point, your real-time guarantees are gone. There is no need to
worry about anything here since everything is lost.

> But no matter what, the above are merely my personal views,
> and I respect the maintainer's opinions.

Restricting it to user context is reasonable: Here you kill the task and
need enabled interrupts in order to send the signal.
For kernel threads it is not needed because the "printing" happens with
disabled interrupts anyway and without any buffering. Should this event
not end with panic() then it will kill the kernel thread and enable
interrupts before doing so.

Sebastian

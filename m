Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9512328E0
	for <linux-rt-devel@lists.linux.dev>; Sun, 19 Jul 2026 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784477797; cv=none; b=n5/hnPeM7PBebKSIDmUgdfgrQLqdKhmVGOxDSsvp8X8SXV2yhBAsVMV1WR3vkFH5h1+e051t56XrGe9Kx4DFTfPxICrrEx6wmX0hkRue4enzTigKDNzwhcT25owZgWChZUQs7eY0Hhbt8W8lqRCw06/xp5SitqITB1z6gOCT36k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784477797; c=relaxed/simple;
	bh=hc+Uu5B4Pr31upaB0ZYC3BWeYXlQeUwcSQjw/S89tiM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DWnUYEPgdMNqHNr4CsOrM8XnQFbTUE3AVEnRI9gybsWxOYe9wpKTZlj0b5qVtCHC7tvyLyMK0UVvv1LqlS7S5jm1qnBWtKfXn3WLviF0OpDJbX8+gyVN7oxUO9AatJ0ozolLkaBXQTm4sPdBF2MU1MaQGLMszDvib8y+o4SuQ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=KzDXjZfr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pfGox4F7; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="KzDXjZfr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pfGox4F7"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D2C601D0008A;
	Sun, 19 Jul 2026 12:16:33 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Sun, 19 Jul 2026 12:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784477793;
	 x=1784564193; bh=gUI8HSQOXw19CzEPGprG8sSdxiuNnVK73lzrGltq7Hg=; b=
	KzDXjZfrgAUl2dEnS+vRuOSZS2ScnRK3O3VDLx8AkyDaxd7/8hXJ8nVdyQ1ovfpQ
	IZd1GerY8DD19fG3B8CwdyQxlztkZDlZeWBeOmgM2Y5AKsynbnztbYOpKYe0SAbv
	HTmcP1DOjfeYh7qgp+Gj6mFtCG/PABgKkXTzp4HDnqIZGIq2qUuJcK6QWgtYiqOd
	OgwypOKkdOPjO9UmFR7Vhyu+XFoTz04td0e6xElef5XsScNvGYoSaXm+I0XT67F6
	uzqxi9CRHNgq3OO89qQq2013KhPH6fmkCe+ehTgcZ2iXmD2kvyjl/ESIcLd8+EQ3
	bXR9/MVitfpxnXWkceeTMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784477793; x=
	1784564193; bh=gUI8HSQOXw19CzEPGprG8sSdxiuNnVK73lzrGltq7Hg=; b=p
	fGox4F7LtzBaRhltglocYc2n8QSaZ3HQExqQ4BzEZRbmcD34sfqCYjnn2UckP+4Q
	IKJvI0xEvA9aqq0XgrjsxEZhWvc24DgzLxLyXsKEaLszDoK+zKgr3Sf0umL3e4gG
	tSve268bCrJcYNgQ5J880v5zovjlvxGKG4UQMQcbXNDhg+LUynp7LYPxSgvQXRY5
	Hef7gIJrHoVX96Vhs+l0DXPAuxRWDsWfEQfaLiu9+fTvInr9mKKyQvzslli/4lw6
	sy2gQmqgJxiNv9ykZNXkKZeJ0FpZFkfdM4ZYJfONU0tnagbygeZmYH8lc8nzWSSF
	FYmn8nN9JnKeLXgj1a3eg==
X-ME-Sender: <xms:YfhcamL5gP77W5b5EtW--sUoHioqCmwJUZEWkMmr5N_8bUF5F6o8Hw>
    <xme:Yfhcao8O3_pUc1hV_UhdNpqSrJjI4PsI9zGqSYhgtSMOuFGIMJ_nptmDYLfunt9R1
    7OPMVVEW5i7OCJUW82YLWq81TW3MLIXusaYksPz-qfqL7TP_p0W7pA>
X-ME-Proxy-Cause: dmFkZTFZIUlrs9grJOP06jOOFcoKJfWGUmI+xcYEiHT2X0/Yq5Uc1CZHrWm6uAvYf8eyky
    ILq8pHiuNd5DlTAMqquKf6pBfFJRrz0JdkjQJdUKU2a/sk15Z8mEsnyrf4UuG068H2uayW
    jTmQV6pE1tbK3u6aTNt+AjMoMFc7+bBip33x4T/Zpq0VwpAzXvfMepJ78YhZfEPT6TY5nK
    UvRqB+kTH8Srlk3Rlh3K7cGiUhIuet4s9FiVQ+aPtispo9FhX7VtW5coD9f51JlJJ1PVms
    RBa7PQ8UntvhBS9uBT8tkIUEH/43MZs5VandMnOrBMRS2a2C4aPc080lC7FfFpWVlqFUUr
    H0+i0Dej4u7LwrGD8mbDsd8aqmIyy3NIs8yycQObnFwtL4cs+fDdNXLHKckx36srmbICq0
    0KvlG6L/GJUXFil4e0QpBGWeNJ79oxX3GZ7zPykfroXW3ba2Je+aZHpTOK0H7w0ocx5JGe
    wUWIQxs4Hj3XfbS+kqZ5s3xQcZUivyHdlmFAn+gBD4uPH+8rqwLgiyK4jwe+C0gjz1LTYo
    eNz4YyLM6nTj/Wyce5G5NRU1XH6GanhyXnJiWJp1pK7kSK8xnPjceSTSN9QXeGEOJu6H9Q
    THSU4ZgF8SLuKtGNvIu1fTleo5LfrtFeisT+088KU9xRkTxnTNhuJxtyGh9Q
X-ME-Proxy: <xmx:Yfhcam9q4ygoHsMT5eRhCff3fZfa2JF0rwm2K5ecLBHAurVXaUw87A>
    <xmx:YfhcaqZMORLks6V5zc4XLFnymNVSU73OwBri7fy8g60jCnXBV_ZU7A>
    <xmx:Yfhcal0hDiMPWepO8AkE1DrPJrEmjwPd5dzuRPkG0K-5SXSzAwL_XQ>
    <xmx:YfhcalYyp-oiFPXhzgAClejWD-Jqye54OCwW4EBkl6roK-DJc_-msw>
    <xmx:YfhcakHrlrT1xoapI4m5ir4xQhUadEksdz6p4bzhd5zwODxZShVFbgEy>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5B922182007E; Sun, 19 Jul 2026 12:16:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: A1Km0dGv5oGo
Date: Sun, 19 Jul 2026 18:15:52 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Karl Mehltretter" <kmehltretter@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Message-Id: <c919c86b-2e12-487a-8b25-66540bca0ecf@app.fastmail.com>
In-Reply-To: <20260718214515.11275-1-kmehltretter@gmail.com>
References: <20260718214515.11275-1-kmehltretter@gmail.com>
Subject: Re: [PATCH] ARM: select HAVE_POSIX_CPU_TIMERS_TASK_WORK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Jul 18, 2026, at 23:45, Karl Mehltretter wrote:
> Commit c6e61c06d606 ("ARM: 9463/1: Allow to enable RT") enabled PREEMPT_RT
> on ARM but did not select HAVE_POSIX_CPU_TIMERS_TASK_WORK. This leaves
> CONFIG_POSIX_CPU_TIMERS_TASK_WORK disabled, so CPU timers expire in hard
> IRQ context.
>
> On PREEMPT_RT this makes run_posix_cpu_timers() take the sleeping
> sighand->siglock:
>
>   BUG: sleeping function called from invalid context at spinlock_rt.c:48
>     rt_spin_lock from lock_task_sighand
>     lock_task_sighand from run_posix_cpu_timers
>     run_posix_cpu_timers from update_process_times
>
> ARM handles TIF_NOTIFY_RESUME on all return-to-user paths, including v7-M.
> ARM32 KVM host support was removed by commit 541ad0150ca4 ("arm: Remove
> 32bit KVM host support"), so the select need not be conditional on KVM.
>
> Select it to defer POSIX CPU timer expiry to task context.
>
> Reproduced with setrlimit(RLIMIT_CPU, ...) and a busy loop. The same path
> is used by setitimer(ITIMER_PROF or ITIMER_VIRTUAL) and POSIX CPU timers
> created with timer_create().
>
> Fixes: c6e61c06d606 ("ARM: 9463/1: Allow to enable RT")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Indeed selecting HAVE_POSIX_CPU_TIMERS_TASK_WORK was previously
part of the RT patch [1] set but got lost during one of the
updates before the patch got merged.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> Found with a self-hosted syzkaller instance patched to fuzz kernels on
> QEMU's versatilepb machine (ARM926EJ-S, ARMv5TE). Runtime-tested before
> and after the change on that setup

Good to hear that this configuration works with your patch,
I don't think many people have tested ARMv5 RT recently.

    Arnd

[1] https://lore.kernel.org/all/20251030152253.tK-rY89Y@linutronix.de/

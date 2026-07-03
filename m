Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD60F231829;
	Fri,  3 Jul 2026 05:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783058035; cv=none; b=kr8Tm730CCFonMmRjsNckKm5qwJpNkcrrQhFTIbl63AtVtdVUI0FvjbM3f5EKQDaT5R0HvSPUyMx6dUQuc+HoR8YAMvvFSEyo5wUl4e+bIo5hyO2elGbbjTWl9lCEa4brUGsguG/wDlI2VTCiyDIvvot/ssjkk1bJDFyUnXzbCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783058035; c=relaxed/simple;
	bh=gA+ohpEGOnnmWlMVdE7Hf5DmX580TNPRdJTBWNA/H40=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IjLwLeSfm9ZChPphURZjqltJU/6jQgA+8gk08CgQpcR8HHF0NklNpnWkwkbU7mqlDdWdpe2NsoGQLya9Czxw0d9Yj1PM1zknGi9L1BUJGwtYJ5B6KrX+STY/Y940Jc7P0GfKtjopea+vjH23v8ATEOnNRle78vRWeaphbaXSBvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KrI4skxM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cju51aBC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KrI4skxM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cju51aBC"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783058030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CrTTbM/MoRg1HsY6OQkPKeGxlPQ5We1d3Cm/DFl3UGM=;
	b=KrI4skxMxTZ5bBQqRl8ooZsbyFfkzyx7GwK4QDUq7wxU9LPWxbf3QqcJh/fJaVWvFJNG36
	8QPreHG1abi4++wQDCwc5OziccH0dk7yUV9ignlzvhBTXJxpfTIzo19hYQf+NHOyjTF215
	oOcF1hu0dIS0aGcxB2khIfmJdmOnxbcpNtAneRFkpo5ukuOhYsh8e1weaFctzKUJVGzfkk
	hYIxecB6/ZomxyM5vsmEc8tUl2WzD9KXPcVVL0GjVLcY8hefi8DXrHc2w3SNSjaKt+A9+V
	1kDo9vb9/jyX1+r6Zrc9WLWmhGgnaWCdQw3UciWjw1r1sG7No7/ygt8QRL5lYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783058030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CrTTbM/MoRg1HsY6OQkPKeGxlPQ5We1d3Cm/DFl3UGM=;
	b=cju51aBCxPfqAvl1nBObWLPvCTEz4j8Y+yLjPRSoWoMDK5ZmsRGe4LVSylX8WL+CX3P1jY
	vOF4P9uJLTo5jeBA==
To: sashiko-reviews@lists.linux.dev, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] af_unix: Do not wait for garbage collector in
 sendmsg()
In-Reply-To: <20260702163608.0207A1F00A3A@smtp.kernel.org>
References: <cover.1782922354.git.namcao@linutronix.de>
 <e663a83195f3d9f6d7ad4907c37ae3e45c151062.1782922354.git.namcao@linutronix.de>
 <20260702163608.0207A1F00A3A@smtp.kernel.org>
Date: Fri, 03 Jul 2026 07:53:48 +0200
Message-ID: <87mrw8sjo3.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

sashiko-bot@kernel.org writes:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Garbage collector is no longer scheduled when creating new inflight FDs, leading to permanent cycle accumulation and -ETOOMANYREFS failures in isolated environments.
> --
>
> commit 506189bd29f8ad56f5d9e51f3e0216203ebad5ec
> Author: Nam Cao <namcao@linutronix.de>
>
> af_unix: Do not wait for garbage collector in sendmsg()
>
> This patch removes the garbage collector scheduling and waiting from the
> sendmsg() path for AF_UNIX sockets. It aims to prevent priority inversion
> by relying on RLIMIT_NOFILE limits and asynchronous garbage collection.
>
>> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
>> index 0783555e25266..f180c59b3da9d 100644
>> --- a/net/unix/garbage.c
>> +++ b/net/unix/garbage.c
>> @@ -300,8 +300,6 @@ int unix_prepare_fpl(struct scm_fp_list *fpl)
>>  	if (!fpl->edges)
>>  		goto err;
>>  
>> -	unix_schedule_gc(fpl->user);
>> -
>
> [Severity: High]
> Does this removal prevent the garbage collector from running when a process
> creates isolated socket cycles?
>
> If a process continuously creates socket cycles (e.g., passing FDs to each
> other) and closes its local FDs, the sockets reference each other in their
> receive queues, so their file reference counts will not reach zero.
>
> Because the refcounts do not drop to zero, unix_release_sock() is never
> triggered. By removing unix_schedule_gc() from unix_prepare_fpl() here,
> unix_release_sock() is left as the only trigger for garbage collection.
>
> This could allow the inflight count to accumulate indefinitely until it
> hits RLIMIT_NOFILE, causing subsequent sendmsg() calls to fail with
> -ETOOMANYREFS and permanently leaking the network namespace unless an
> unrelated AF_UNIX socket is closed system-wide.

Sashiko found a valid issue here. But this is a pre-existing issue. It
is not introduced in this patch.

unix_schedule_gc() does not actually schedule the garbage collector
unless user's inflight unix socket count exceeds UNIX_INFLIGHT_SANE_USER
(2024). So user can already accumulate up to 2023 inflight socket counts
without the garbage collector running until unix_release_sock() is called.

Nam

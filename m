Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0792E238166
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Feb 2026 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770058800; cv=none; b=lgOwqZKgj3AHWUnRuyNBkzQjR0JZGZU7i031KR76bFy+I3yGcU4eKLxrlXYhPY0Xq/rKohu0oQde/lLnJvjQAJB5DnvOyaTSy8d4cRqlCOgBWEsUNmH1aEzMTitGb7+JowcvUEcF3KB3/Gi7DAY74s42mZHNAXhhJVtzYP/WaRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770058800; c=relaxed/simple;
	bh=uJFlCWSkQ2rckMjduK925ZLMy1kmdXPL/YHdF0/x1WA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WdVOmbKiNT36yw35efGzFJ2GTq71nkAQrGAasHXsx0hbSZEme8nNdMWUZ1XrYWDNl8HdYrj8Vz70HAmUl4h0jD26omVjVfXeLZakpZ5EY9kW/NfJj9T/P61o/BLp5Zucry9m/5reKKD1DErNPbsKmpsDQ8xKnRbNY+1NzJJXkmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiredspace.de; spf=pass smtp.mailfrom=wiredspace.de; dkim=pass (1024-bit key) header.d=wiredspace.de header.i=@wiredspace.de header.b=oNfPVB29; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiredspace.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiredspace.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wiredspace.de header.i=@wiredspace.de header.b="oNfPVB29"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiredspace.de;
	s=key1; t=1770058787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uJFlCWSkQ2rckMjduK925ZLMy1kmdXPL/YHdF0/x1WA=;
	b=oNfPVB29AO++T6ikbEMhLmI/5uYqUBtY6ntgeUKW+bOLnvMomgZLX7XkaOyQumrRUgMd+t
	jiyVWWgvsqVUXawOLYYI5QGcIeL6qXpiWTVzTM9PZCGY+iGxsimVfWMwzYlRgcYxw9uvRH
	Xwl+URTh18QxQbmpSHGYYXmFMHs2qwI=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Feb 2026 19:59:43 +0100
Message-Id: <DG4PGZN9OM5B.301RXEQEIVB7@wiredspace.de>
Cc: "Clark Williams" <clrkwllms@kernel.org>, "Steven Rostedt"
 <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH] rtmutex: Introduce __cleanup() based infrastructure
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: =?utf-8?q?Thomas_B=C3=B6hler?= <witcher@wiredspace.de>
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
References: <20260202-rt_mutex-guard-v1-1-1c078dbeee57@wiredspace.de>
 <20260202175840.-IHSZ_Fn@linutronix.de>
In-Reply-To: <20260202175840.-IHSZ_Fn@linutronix.de>
X-Migadu-Flow: FLOW_OUT

On Mon Feb 2, 2026 at 6:58 PM CET, Sebastian Andrzej Siewior wrote:
> On 2026-02-02 18:04:43 [+0100], Thomas B=C3=B6hler wrote:
>> Commit 54da6a092431 ("locking: Introduce __cleanup() based
>> infrastructure") introduced lock guards for mutexes in
>> include/linux/mutex.h, but, presumably as PREEMPT_RT wasn't merged at
>> the time, the guard for rt_mutex was never created. Do this now so this
>> infrastructure exists for rt_mutex as well.
>
> Wait, what? rt_mutex can be used independently of PREEMPT_RT.

I wasn't aware of that, sorry for the confusion. I'm still pretty
new to the Linux Kernel; my assumption was wrong here.

> I suggest you focus on what this patch does in its description and
> repost it with the locking maintainer in Cc.

Thanks, I'll do that for a potential v2!

> Do you plan to have any users of this?

No. I discovered this was "missing" while developing out-of-tree. I'm
aware that an interface should have in-tree users, but I'm also a bit
confused about who is using rt_mutex in-tree in the first place as it
looks like there are only a handful of users.

I'll make sure to do more research before I might post a v2.

Please do tell me if this isn't going to be merged due to missing users,
I'll drop this then. No problem, and sorry for the noise if that's the
case. :)

>> Signed-off-by: Thomas B=C3=B6hler <witcher@wiredspace.de>
>
> Sebastian

--=20
Thomas B=C3=B6hler

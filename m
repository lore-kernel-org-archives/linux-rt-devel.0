Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AB624A06D
	for <linux-rt-devel@lists.linux.dev>; Mon, 11 Aug 2025 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754901100; cv=none; b=V6s7izr2jtxEOqkTqyEQdTAHE4LrGf+Of4ZiUVWDZ5Y9TTFs/3Gija3gVW0nIhRCZ6v5cR5itvmpLyVmfMil5PZ/v+Z+a/5rm+Y9eaKhwC58n4CS+9QcX8oig6/EThMroB8LDc+5oGWICfGikhj3O8g/lNSOtpFZ2WOkehnDJdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754901100; c=relaxed/simple;
	bh=S4WuqofBa7Id6+qyAJHjdL5aqwr5DwpyzeUXtsy52u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucEm7d3kLLboYRfAIEx+texHBT+ZyR8cXTNoegiz122gMUs30HvHFjR9sZTk1QLN/Lh7PU9GM+RVBtRlYQ26G9kOVB1WB5blU9cpdn+XR9Ec1Hvn6WQhUmMoi0NF37mvrGSsfImvAtXQAYig9fRN2fpPSkcjmTIJwDiz5Adrl58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cZNO6N2q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lqsQIrkC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cZNO6N2q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lqsQIrkC"
Date: Mon, 11 Aug 2025 10:31:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754901096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JeEYEDHr31+P2zVZyryZ2NEbaRwQuOh+nfUwKPEWE1U=;
	b=cZNO6N2qunmSklZQNVYCQo5IIj9bIBmAgbV7ljn82yCgNMKRsvql6lShJ81ecxTLm3Cea8
	s3Svi0EEJp2Z0Z1KNm6/DOaQwM74D5fo7OHtBHgOUewLhzgfVW7ElqxhU7QH2+rdFkTz0H
	5/ogT5fYhQQgIjujBsmwXkk30pSWnTcsXE0qO0BbqPkrTRVIpPrK4xSgLlrMEx23lfuwnm
	t868ImjD2MHvJmsiQgOhLztDE14D6VZVKfntxVHLvu+MvTj9MckEanpgP5OuuHzuRT2a+9
	Fk7Qo2knjuhMizdljcbbowfyNlMdH7i1H8LIZ9hMor2fYvRSgGtezMPKLvmRGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754901096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JeEYEDHr31+P2zVZyryZ2NEbaRwQuOh+nfUwKPEWE1U=;
	b=lqsQIrkCdbT/b7o7yJ8/W5Y9Megw6NnMf5v16x2yzUciE9/VpFNPrhZstXL2XVYloQ5foV
	lc3jcWA8RlDD2IAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Byungchul Park <byungchul@sk.com>, max.byungchul.park@gmail.com,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Michelle Jin <shjy180909@gmail.com>, linux-kernel@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org,
	kasan-dev@googlegroups.com, syzkaller@googlegroups.com,
	linux-usb@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Austin Kim <austindh.kim@gmail.com>
Subject: Re: [PATCH] kcov, usb: Fix invalid context sleep in softirq path on
 PREEMPT_RT
Message-ID: <20250811083135.xtl2wSQz@linutronix.de>
References: <20250725201400.1078395-2-ysk@kzalloc.com>
 <20250808163345.PPfA_T3F@linutronix.de>
 <ee26e7b2-80dd-49b1-bca2-61e460f73c2d@kzalloc.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ee26e7b2-80dd-49b1-bca2-61e460f73c2d@kzalloc.com>

On 2025-08-09 02:35:48 [+0900], Yunseong Kim wrote:
> Hi Sebastian,
Hi Yunseong,

> > Could someone maybe test this?
> 
> As you requested, I have tested your patch on my setup.
> 
> I can check that your patch resolves the issue. I have been running
> the syzkaller for several hours, and the "sleeping function called
> from invalid context" bug is no longer triggered.

Thank you. I just sent this as a proper patch assuming kcov still does
what it should. I just don't understand why this triggers after moving
to workqueues and did not with the tasklet setup. Other that than
workqueue code has a bit more overhead, it is the same thing.

> I really impressed your "How to Not Break PREEMPT_RT" talk at LPC 22.

Thank you.

> 
> Tested-by: Yunseong Kim <ysk@kzalloc.com>
> 
> 
> Thanks,
> 
> Yunseong Kim

Sebastian

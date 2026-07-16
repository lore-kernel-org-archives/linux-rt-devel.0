Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664C641DEF5
	for <linux-rt-devel@lists.linux.dev>; Thu, 16 Jul 2026 12:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205127; cv=none; b=F/cP+CGmDkA5a72CZYGUIMTcDp/NTuiiQFlVycbq0Ri1sB5OHDwkiuXRC/JYewH7EfvZymg+MSr4edj8JTX29VuSNlHSF/bbzhxW92Ke2QZHNDegCOd7uIZZBplKKiFkSFgi7w3Z93Jatpopg9Kfu9Q7e18FL47ljY6gA9CftK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205127; c=relaxed/simple;
	bh=zCU6xmfTX9QzkyBnasHzSeON0pFdLolz8O2D4BiCm5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sn4X5z0f8wp3/76mIYiJpazs/LedxtEiOV2HTS4Nis+SWhejrG9TMJKfa5HEsYueTQw/P3YEpNA1MWNRNFDibNmfrz8osi7NzK/KBuppXRcpZANOGXNHeCBsTFpAOfgfPVu+MhXZCVKpBpvVbVcW2/C11Ey+RUyAjlAHw34VDWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yJ+Rd6z3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5YEyOcbg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yJ+Rd6z3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5YEyOcbg"
Date: Thu, 16 Jul 2026 14:32:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784205122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p02jWear9ojHlPOPiERrKgnPe8UT/Y0nFaclwcK7tJQ=;
	b=yJ+Rd6z3kDm9tqtkHB3J8VIwnZeM6p3zMqTumPqpPRCwzm8SAZ+TUc3mH91NZbhYOQhu6G
	cXgh738FDNQ9CVW7Ta9hHzBVVT5yJmPQ7pc4Rh8SmNqzioYQrAfJNbKFq0o4d7K++oEasa
	ykyHPIapw7jHnDor8mDwZewUuxsZ9gt+NTNvUwk9SOdNWmIltoNjGt6n/V5z1763IBTz/p
	LQbiTZkuq/MB5eBhotGeAI9B0+JNLdwaeWUiQZ10jlwfZUKNR87t++ci5bNzojWF9+7bPJ
	X40Tsile7avmFJMjS2i+mZaX4fcBUS+dJwUr1DKzsTgmVen86SC4gXFhCp13BQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784205122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p02jWear9ojHlPOPiERrKgnPe8UT/Y0nFaclwcK7tJQ=;
	b=5YEyOcbgI0hkRCxiZAny+3KB16Z7IAlYfKIhWZ+N2TV/uAQBHBFJmOFzqX7GCJf0aZGgi5
	vKDWQfbZaAM8fDBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: MOHAMED AYMAN <mohamedaymanworkspace@gmail.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"moderated list:ARM/CORESIGHT FRAMEWORK AND DRIVERS" <coresight@lists.linaro.org>,
	"moderated list:ARM/CORESIGHT FRAMEWORK AND DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH v2] coresight: Fix scheduling while atomic in
 coresight_put_percpu_source_ref()
Message-ID: <20260716123200.XCGRLZCH@linutronix.de>
References: <20260712210446.14290-1-mohamedaymanworkspace@gmail.com>
 <20260713230028.8046-1-mohamedaymanworkspace@gmail.com>
 <20260714104252.NuPnAQyJ@linutronix.de>
 <CABWZVho1=oJHU6U16Kc-Nh1bQbn07oz7PPkM9Diy=JS0beGjFQ@mail.gmail.com>
 <20260715065832.qI7c2Px5@linutronix.de>
 <CABWZVhq5yN6uP-YJC07EVt6+AqmGoUcXx8RTdrYssQ9coQ1Q5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABWZVhq5yN6uP-YJC07EVt6+AqmGoUcXx8RTdrYssQ9coQ1Q5Q@mail.gmail.com>

On 2026-07-16 06:07:35 [+0300], MOHAMED AYMAN wrote:
> Hi Sebastian,
Hi,

> The fix would simply be rewriting `coresight_cpu_get_active_path()` like this:
> 
> static struct coresight_path *coresight_cpu_get_active_path(enum cs_mode mode)
> {
> struct coresight_device *source;
> struct coresight_path *path = NULL;
> 
> guard(raw_spinlock_irqsave)(&coresight_dev_lock);
> 
> source = per_cpu(csdev_source, smp_processor_id());
> if (source && (coresight_get_mode(source) & mode))
> path = source->path;
> 
> return path;
> }
> 
> This means we don't need `coresight_put_percpu_source_ref()` inside
> the PM path at all.
> 
> Does this align with your suggestion !??
> If so, I will prepare a v3 patch that drops the workqueue architecture
> entirely and just applies this much simpler fix..

It looks doable. I don't know what the lifetime expectation is of the
`path' but this returns `path' object on the same rules without the
get/put dance. So yes, why not.

> Best regards,
> Mohamed Ayman

Sebastian

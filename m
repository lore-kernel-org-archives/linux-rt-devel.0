Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA3337FF5B
	for <linux-rt-devel@lists.linux.dev>; Mon,  1 Jun 2026 07:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297251; cv=none; b=b8UDGPY1FTM5Lew9xmE+ZMvgahdcps1soHQBkZV9DPLcqrlq9GguDgNoybv6PpTf3q+YsxJVGrb+GjaNQYNrY6gENgQKvXwcuQzdv0Mx7wWmmXqPSlpn92FeeSE9jxpK2hRTmSNL8YYDGA8K54NakhkYHFzHx8Kzykq0fIv3y28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297251; c=relaxed/simple;
	bh=FtMgwKmV6UhO5gxjh1OgBDWGM6OkI5/cZHnoLiGRjj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5XvOlwWT5Zpxg9t2HhU63q+pBsE087xeiCgtziA0XsVB7hYF41iotYX/wSXRvTHe1G/cRHvbcxM3Ckw/alLbHc4V9qhh7qD2VKVV1porzTwo4SZS6Y686tNJA1NX0f+72kpg2RkQ37ZeeGCjpHZoxDRIjVhiYiAqJwVU6b1g0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kbb3CgDm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7/9Tz9ud; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kbb3CgDm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7/9Tz9ud"
Date: Mon, 1 Jun 2026 09:00:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780297247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BZWbX6EVvXIYtfo1TGDGyyFNKCDwYGa82lcwcbE3N74=;
	b=kbb3CgDmRqSJCW1dQApXOh6gnZMQW0n1Dwsh0no7y3u/Sloh5MOI9gZr83q38n1gcTcAPA
	Q0i2KqigATolj7ecQgwN02hC9zuXapbZ2MeTXUjHCPh2IsAh+D02zOiISnXacANdmK9Epd
	TYs784tjnnxVBn5aC+NyQmzorUnTvvxbT0q7nmEL9soOAyqe5GpWI53WH3mZ7yKXz/DsEt
	l3zraltOzqTg8xBeRybh2f7+YILAWcDkKfz0PzWuiDzX1c2FN07eZtqloKVQA8xjXjMM46
	/3wRywIgeCpDmGNVjWqMmCi+N9CyBmCjyb61wenpLwYr7abBZcwpyY0CWkJKbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780297247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BZWbX6EVvXIYtfo1TGDGyyFNKCDwYGa82lcwcbE3N74=;
	b=7/9Tz9udWlk+RRPHcp9IW7iMYwoleW4jdnUDfjBxnYBBFRPfJvYbPCUnJwa5g5q7BOL9BL
	5u5RDDeqfmgtWuAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] docs: real-time: Fix duplicated sched(7) text
Message-ID: <20260601070046.l5gSZHm5@linutronix.de>
References: <20260531141823.4118954-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260531141823.4118954-1-costa.shul@redhat.com>

On 2026-05-31 17:18:22 [+0300], Costa Shulyupin wrote:
> The man page reference appeared twice - once as plain text and
> once as a hyperlink. Remove the plain text duplicate.
> 
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

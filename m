Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7853AEF23
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Feb 2026 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022782; cv=none; b=D73sl5ZGIoYND0fgQiuX25ULSBq221AIiOyf/GELWvITvAqxx/tn1iLRmWOCOn6w9D00s8SYqXK65HtNwT3T9bFXNTm1K9be3/GYYKfnTd8som5vYUC7mtQLW/8hWmv1XAIwWnvVIwuNjTpHhqrKGqXgd5GwA90hEKowus90rz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022782; c=relaxed/simple;
	bh=JMqJdyv/tZPCdVSQBG9OTpQD8Nys7penXlEHC3gj99E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D6TKAU+oo5ePoFfRThylyjrhctcf+M/WKjSct7Gl2PEgbSMHPs8yACEkhKZUsXWlENLxABJvlDC4MIdoAuX5RTGG4Lwp5aIMdwNlj/jFaVm6Pcbpgl9uZm7vgqvSgnYl+ZpOMyvkP/WWolBiHtcBJEE7JmO5RLr7OFz6cnLjQhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=F4V3LuGj; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="F4V3LuGj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1772022779;
	bh=JMqJdyv/tZPCdVSQBG9OTpQD8Nys7penXlEHC3gj99E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F4V3LuGj9CGfwWjhAM/mbQsGlLtMt+t0S4Tk+NuwcKwsheVE8sv05fXOQ0RveS8LE
	 oiRaIwgdPjxI/lKK+0Bw03W1Xj/KoI2Ty2ADmkjA95lJLnnAxzhhJfAtDsQtP9y7yW
	 geXx+pgB5ZOmaIe2PHgLjRw9mCMsnRXMxppYTBRlRumPSDhuDLslxhOv3iYrJX2SIp
	 jXlC9a7la+IEkfH/ZG6WjZ1OysBEXRfwAhzs2J/7immrXb/nCwb4KDncNtuvoV4nlw
	 BCikZPMBt6SnayrsrL2TVEbsJ3rbhQEQeI8wcUPzYstcZ1DZaJ9JHfSmkYLk2+9y3f
	 c/7yH1fXaHR1g==
Message-ID: <4aac9ace-4529-45b3-9ac6-065d7415699a@lankhorst.se>
Date: Wed, 25 Feb 2026 13:32:57 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [i915-rt v6 24/24] FOR-CI: bump MAX_STACK_TRACE_ENTRIES
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-rt-devel@lists.linux.dev, dri-devel@lists.freedesktop.org
References: <20260220083657.28815-26-dev@lankhorst.se>
 <20260220083657.28815-50-dev@lankhorst.se>
 <20260224141542.cDL_xEWb@linutronix.de>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20260224141542.cDL_xEWb@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey,

Den 2026-02-24 kl. 15:15, skrev Sebastian Andrzej Siewior:
> On 2026-02-20 09:37:22 [+0100], Maarten Lankhorst wrote:
>> We're hitting a bug in CI where MAX_STACK_TRACE_ENTRIES is set too low.
>> My guess is the repeated loading/unloading is creating multiples of the
>> same entries. As a hack just reset lockdep. This might only be necessary
>> for CI + PREEMPT_RT.
> 
> spinlock_t on PREEMPT_RT uses the rtmutex which from lockdep's point of
> view counts twice: The "logical" lock and the inner wait lock. That
> makes twice as many locks. I hope it is this and not some accounting
> error…

Yeah that will probably help explode the amount of entries, thanks for
the explanation.

I'm running out of entries with default PROVE_LOCKING settings on PREEMPT_RT
within a minute of booting.

Kind regards,
~Maarten Lankhorst

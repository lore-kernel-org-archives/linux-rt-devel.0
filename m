Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777352;
	b=hJVkYOpvAskuSLdbXOBrBqbVZk9qJEXCSep/XnwSEUpDUHiIv+vBpTTzhh/Y0c/oMtKd
	 Yc2orH2rYZw+/HhhwmOmUR7HQQ2nwJ2u8d11y1N4HWoNAINS+ruxMGkFBnL0mX4RqSH48
	 F9sJMC9LwMDk4pwXfQc6tZ7T/9UyznHW6KZ9W+qXsdgKIce7iQpyDZaMnF0qy+b+5yqTy
	 qZiHcuBn1kLxlQPdQPxR6EhYRa5ZdXMlKlLjnf+luICHGuMqno5sUCHYSLt294g7M3VQr
	 SSB1LcyPvVqiaTu/aWQwrCSIqyQbPd9xawI0sG+XHl1NSdkZ99l8VTEIIV+m5C/Arjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777352;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=bcWSoELoZUIQqPEXnwwT67IHNTGhsjc/m/zyxwGltSM=;
	b=wvs9oKpSXxXLxwxfWc+OYsoYPaem3phZEmfWh03p4Ppoj2AcyCcZc1MIBtorkPsmkj8z
	 v/cKBnShwzVP24Pz8N3rblaRxNujEg0rPtMmOJ4qyiOLr0m4AH44V+969I33GkdRx2msq
	 xUZuNHrN7Jd0FGnNUlKpyI09imf+glI8mPTrx936NZsVCuMuSuoGkKrubILdvi8jedIhl
	 MGTwMR0uIfFesxA2TVwad00nx3H1Xlr7iB22Poh5eRdLy88Bed0OI/ZqywR28tN6MDBD6
	 KsA3dFq/higHJgwNNmTtXZMMNI7Kus8Q2Wb90R5IhJCtnYA7RgIUR8BnFQ0bCrPehpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=b+mXYGKP;
	arc=none smtp.remote-ip=95.215.58.154
Received: from mta1.migadu.com (out-154.mta1.migadu.com [95.215.58.154])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AF5606A33A
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Oct 2026 17:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72AF5606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=b+mXYGKP
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=ZWpG74j7wmSfnis216vButk5kYT9Ocdsw3b4bQcD9NY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792777348; v=1; x=1793382148;
 b=b+mXYGKPnudrQs9Omcdc6N4GTttsd3DJk0fnLGTfpbmajEoOPc6Svj/hQQW1PmWj+EquTi5G
 OzHKT3v0P3dO39qnsNScDLBoKe+kn8J/7XOI0zLL7muv8pfHV0JCdRHnZJ+vRYgDfdWUOJKgqnG
 ZZJB3DTH1wi1PQU+T23uSwDY=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id b5a5d6b9e98b6294;
	Fri, 23 Oct 2026 17:42:28 +0000
X-Mizu-Trace-ID: b5a5d6b9e98b6294
X-Migadu-Flow: FLOW_OUT
Message-ID: <058f0fd4-ed91-4e9b-84db-90e0a3aa5d19@linux.dev>
Date: Sat, 24 Oct 2026 01:42:22 +0800
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6.1-rt 00/15] net: Backport backlog-NAPI threads to
 resolve PREEMPT_RT softirq warning in SMP flush
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev
References: <cover.1791912669.git.wen.yang@linux.dev>
 <20261014150853.f8I2fNx0@linutronix.de> <atDWZDywit4ilzJ8@demetrius>
 <20261015133811.PtBdJYyx@linutronix.de>
 <2c3a8c0f-3820-4531-b179-b2656a7d3c7e@linux.dev> <atJ0axhl3AHQIDsa@demetrius>
 <20261022092536.HVMUjSuS@linutronix.de>
Content-Language: en-US
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <20261022092536.HVMUjSuS@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/22/26 17:25, Sebastian Andrzej Siewior wrote:
> On 2026-10-16 14:00:59 [-0500], Clark Williams wrote:
>> Perfect. I expect you'll have a small series for v6.6-rt and then a
>> pretty large one for v6.1-rt.
>>
>> Thanks Wen, I'll be ready to apply/test when you send it.
> 
> "[PATCH 03/15] net: napi_schedule_rps() cleanup" has
> 
> | commit 8fcb76b934daff12cde76adeab3d502eeb0734b1 upstream.
> 
> in the middle of the commit message.
> 
> "[PATCH 14/15] net: Allow to use SMP threads for backlog NAPI." has only
> context related changes.
> 
> I don't see any SMP-function calls with the series applied. This looks
> complete to me.
> 
>> Clark
> 
> Sebastian

Hi Sebastian, hi Clark,

Thanks for checking and confirming the RPS coverage.

Clark, would you mind moving the upstream commit reference in patch 03
to the beginning of the commit message when applying the series? This
would be a message-only correction; the code is unchanged.

I'm happy to resend if you would prefer an updated series.


Thanks,
Wen

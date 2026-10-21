Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600242;
	b=5jqTNLDqkTs0c673FJxIdlE4Ibv1kp+2/RstZZre/ZrSae/bh2C1a2fJxI3e9fkvnRAW
	 i3auER13OnyyzEkP8dC3qjIoBhkY/fCml4q0JsM6iw+fkX1q2IvmjpSYsQt80Wk6GMJqV
	 1NsiVhpQrW7CS43TZdUqgIVJMuRbZ7Y7eZY78F3+BDC47q+Pe9+jQyQJDkqlO7Bk9l+/T
	 f1Zdej+i4PFpEp7iV4FUHO0nIa9xbF/DFpqL34v+jTQdMKHCCF8HTaK7M1csYjHVLM/vt
	 RZy34LRMftTXVbgwM7TVPqsBRqiMvsF+gOBLI8GicFQFz9KrxDGwBHyu/VrgEDL2R7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600242;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=yI2IBrjD/EwwFBxz9C0DBtizEBBStKNN6HmmrKwPsNc=;
	b=nKoy5cIYAUNNpO9DAcAuNHTxcphadkGLY4FhXLouvwg+K+oFYCrE14L9E06NW75sGmu3
	 fHQ/rpW2hUqJvmnypaXjQYbreNagj7RE2ktW281CMFsnV1PgW8z4CnFCOfQfZ0mPNaKmf
	 rWh4SGc1YRIhGx+gjtoyLnwpRnZJ/vDmdyZOu9zMNoPLWudZbUzkZbBVeTAb4VP7E6Erq
	 7cWRihyUBZg5dYpSdOOcJIIQj59tWFLdLIr2Kw5Wsh3EuuRBM9yJQm9zb7kQkdues2WKe
	 Wy37KcopwFNFbD4R7E5F7mcWZuoyc6kD0GP1Ewy/HcclGfFpMfOb7XJoN8CG8+9Zo7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ka6dKNrG;
	arc=none smtp.remote-ip=91.218.175.114
Received: from mta0.migadu.com (out-114.mta0.migadu.com [91.218.175.114])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CAA606A31B
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Oct 2026 16:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41CAA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ka6dKNrG
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=PgP4HL1xv4LQjoI7vWK/HPX2JuhjD0gGL1S27rjJ1g4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792600238; v=1; x=1793205038;
 b=ka6dKNrGViCBdQLQl/Uirj2oqH3Ek9/ecOF1QQN5W09Qvwdw9BVcWLIGG866A38kaBvhTzSY
 Kl9mjkScpLapKnL6a6GkkZvTgzIA+Ov+j2RIsQa6Cis7Tx5d0BsQhFngXjntwEi/Q70giv3fgBH
 jsqZHS7rtpsveKLSRE3OrzCw=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id d0dbefea6029aa64;
	Wed, 21 Oct 2026 16:30:26 +0000
X-Mizu-Trace-ID: d0dbefea6029aa64
X-Migadu-Flow: FLOW_OUT
Message-ID: <7f5046fd-f38e-4966-a616-0c8d95833eed@linux.dev>
Date: Thu, 22 Oct 2026 00:30:22 +0800
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
Subject: Re: [PATCH 6.6-rt 0/5] net: Backport backlog-NAPI threads to resolve
 PREEMPT_RT softirq warning in SMP flush
To: Clark Williams <clrkwllms@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Steven Rostedt <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev
References: <cover.1792345413.git.wen.yang@linux.dev>
 <atYZLK0gmG8vRHxG@demetrius> <b957b12e-f272-4dbf-a308-c6b61bcb3d66@linux.dev>
 <atZWIBciePyeMnWa@demetrius> <atZmgh0uq6sTdWTc@demetrius>
Content-Language: en-US
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <atZmgh0uq6sTdWTc@demetrius>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/20/26 02:50, Clark Williams wrote:
> On Mon, Oct 19, 2026 at 12:40:48PM -0500, Clark Williams wrote:
>> Meh, 15 patches doesn't suck. I'll try and get to that tonight or
>> tomorrow and see if we can have both v6.6-rt-next and v6.1-rt-next
>> soaking.
>>
>> Clark
>> -- 
> 
> Wen,
> 
> I was reading back through the threads and the previous series and am
> confused as to whether your 15-patch series has all the RPS code that's
> required. I seem to recall Sebastian indicating that the original
> v6.1-rt patchset needed some extra RPS bits?
> 
> Clark
> 

Hi Clark,

Thanks for checking, and sorry for confusion.

My understanding is that Sebastian's comment referred to the existing
RT defer_work workaround, which covers deferred freeing but not RPS.

After rechecking against the upstream code, I haven't found an 
additional RPS prerequisite needed for this series.

Sebastian, could you please check whether this addresses your earlier
concern about RPS coverage? I'd appreciate any pointers to prerequisites
I may have missed.

Thanks,
Wen

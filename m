Received: from mta1.migadu.com (out-113.mta1.migadu.com [95.215.58.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F3A48DB2E
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 18:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792174576; cv=none; b=FXWUibCs3j0LdoHw6rtrS16Qch4xAx7JGrK/nFc9NCLIKIJSfhDysBJUHvWT8sOcH4zYNopTIwEG0MPKFW+M8A/xQX83UxrDU39D3YvvMZj2PnpTmNGtDOOGEzbMrUiIltDi/D+YP4hMtW2abNz1Aqh3E11wr4gYR/1/KMmot5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792174576; c=relaxed/simple;
	bh=hKxqtmnMKzg2k1LHoGfRy7pOphah5CSQcVYEKBnt1W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kUvAeqh3keWiB7WTRCO9pvcFg+nYvOTgI7/4/kMID6eQlnutsljEo20P6PPgLn16j+1AQTC5eQlT1mNvf66qaG9Bx55X61xa2U+Q9gdtm8yDLZT40y9Ngc5tRISVnKUk+R4ZlW4I1ofSTJFi/PX/7uBtS4OZXQ6KLI+dRwYoedk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FBce49R+; arc=none smtp.client-ip=95.215.58.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FBce49R+"
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=hKxqtmnMKzg2k1LHoGfRy7pOphah5CSQcVYEKBnt1W8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792174570; v=1; x=1792779370;
 b=FBce49R+KChj41JlZE8cazB+GRzCeZIc5iOmBIHQ5UXsN2ZbI3195A+e+IvFdVSjHEIAdt6D
 v0E+u2eZZAasqGkDMgaicf3IEMVnnnA/4nBInkGteaxlN29Ug4CKgLmfiHVUtPE8eLfW88iwRfG
 vsHSjjp3wMHYkEEgCOFYU3k4=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id bad43ae743273093;
	Fri, 16 Oct 2026 18:16:07 +0000
X-Mizu-Trace-ID: bad43ae743273093
X-Migadu-Flow: FLOW_OUT
Message-ID: <2c3a8c0f-3820-4531-b179-b2656a7d3c7e@linux.dev>
Date: Sat, 17 Oct 2026 02:16:02 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
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
Content-Language: en-US
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <20261015133811.PtBdJYyx@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/15/26 21:38, Sebastian Andrzej Siewior wrote:
> - NET + proper list
> 
> On 2026-10-15 08:34:28 [-0500], Clark Williams wrote:
>> I don't have a fundamental objection to the backport and agree we should
>> do v6.6-rt first, then move that back to v6.1-rt.
> 
> Okay.
> 
>> So it sounds like we need to pull in the RPS code first?
> 
> Yes. Wen, do you mind preparing a series for v6.6-RT?
> 

Hi Sebastian, Clark,

Thanks for the feedback.
Agreed, v6.6-rt should be fixed first to avoid reintroducing the issue
when users upgrade from v6.1-rt. Regarding the RPS prerequisites, I will
check which upstream changes are already present in v6.6-rt and identify
the remaining dependencies for the backlog-NAPI threads and defer_list
cleanup. I will prepare and test a series for v6.6-RT soon.

Thanks,
Wen

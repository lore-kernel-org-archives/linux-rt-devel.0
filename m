Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1633037AA77
	for <linux-rt-devel@lists.linux.dev>; Thu,  9 Apr 2026 07:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775721053; cv=none; b=T9TtLXtDxr7k3ZZyuOO5vGEwUzmG66eIJC8YPDGxLIKY9kgXUe6yLaIJyeXmlm6NSmmvfxE79e+jfT3MTz+zA4JOXt36QsyqHkk+a2cwewDa6PCAtOj5euBHYs+VnsAi+H36ZlGgE+HnZDJdTmOd0j0+133pa+CmFkHiMIY78hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775721053; c=relaxed/simple;
	bh=x/mDuO5aW+xOYVFPxn5cSkb/K6xswtpfQkRLRJmY8WQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RqeV0tIbIFVVzcnEsk+EGn/ja7qu0r+HAR949Dc84MYTSOUdwwQkbSMarET2vWphNgGCoUtI3RUfINSuiwoS2LnhMGaX6BWF2dfY8rKtcFL2tzBsaJnLrEkayuXdPxDUkpZU0yQILr/tpTNh5sq+6vOsEeU9hoF7qgrvcq5a3QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H0LXRoOw; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H0LXRoOw"
Message-ID: <8c761de0-4d8c-4b2e-89a6-80f12016fd78@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775721049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ctgvjMM21Mfyak3TqaT4DUpV4LWJB/jgFvuY7mWNIU=;
	b=H0LXRoOwVcEEhitNLv6wYSoG9Oz6fMQPfFb3ygTUhBxdAHj4UfkPq8kh7KsS9up+oTkUGs
	N2wjJL1EQS0eJJisdLfNftb/oaaH+CWn+sA4AzkIX8A9vFoVn89LRHj2SxvfqlkvEnbQFB
	bgifR4c8/eUoZFXeVZjFCuLXN5vgplY=
Date: Thu, 9 Apr 2026 15:50:30 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: fix __this_cpu_add() in preemptible code in
 dev_xmit_recursion_inc/dec
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Weiming Shi <bestswngs@gmail.com>, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20260409035344.214279-1-jiayuan.chen@linux.dev>
 <CANn89iLEpVVo=q4FPpBQ5FomoLmdrfW3su7Mb0ZES4EV9=Q4xA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CANn89iLEpVVo=q4FPpBQ5FomoLmdrfW3su7Mb0ZES4EV9=Q4xA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/9/26 3:18 PM, Eric Dumazet wrote:
> On Wed, Apr 8, 2026 at 8:54 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>> dev_xmit_recursion_inc/dec() use __this_cpu_inc/dec() which requires
>> migration to be disabled. However, some callers like SCTP's UDP
>> encapsulation path invoke iptunnel_xmit() from process context without
>> disabling BH or preemption:
>>
>>    sctp_inet_connect -> __sctp_connect -> sctp_do_sm ->
>>    sctp_outq_flush -> sctp_packet_transmit -> sctp_v4_xmit ->
>>    udp_tunnel_xmit_skb -> iptunnel_xmit -> dev_xmit_recursion_inc
>>
>> This triggers the following warning on PREEMPT(full) kernels:
>>
>>
>> Fix this by adding migrate_disable/enable() around the __this_cpu
>> operations in dev_xmit_recursion_inc/dec() to ensure the per-cpu
>> variable is accessed on the same CPU throughout the inc/dec pair.
>>
>> Fixes: 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functions")
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> ---
>>   include/linux/netdevice.h | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index 7ca01eb3f7d2..6b1cd5380d70 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -3591,14 +3591,19 @@ static inline bool dev_xmit_recursion(void)
>>                          XMIT_RECURSION_LIMIT);
>>   }
>>
>> +/* Non PREEMPT_RT version: inc and dec must run on the same CPU,
>> + * migrate_disable is sufficient.
>> + */
>>   static inline void dev_xmit_recursion_inc(void)
>>   {
>> +       migrate_disable();
>>          __this_cpu_inc(softnet_data.xmit.recursion);
>>   }
>>
>>   static inline void dev_xmit_recursion_dec(void)
>>   {
>>          __this_cpu_dec(softnet_data.xmit.recursion);
>> +       migrate_enable();
>>   }
>>   #else
>>   static inline int dev_recursion_level(void)
>> --
>> 2.43.0
> This seems wrong.
>
> The migrate_disable() should happen before dev_recursion_level().

Thanks

I checked all callers of dev_xmit_recursion_inc(). Most are fine.

The only problematic ones are iptunnel_xmit() and ip6tunnel_xmit(),

I think adding guard(migrate)() at the top of both functions is enough


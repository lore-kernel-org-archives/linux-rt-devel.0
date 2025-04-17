Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE44222E015
	for <linux-rt-devel@lists.linux.dev>; Thu, 17 Apr 2025 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744878555; cv=none; b=mR8OBUTuGvGVMJUrOSCmoDenlIEul5B6siILqaZWE9O9jJ69V993RwlMcFP1UFX+5SRBN4IJXd2RgEEESiOLIINu4ew8Bx/L5LnswBuHqumegjdDNhl1J+8PcD+KoFhWSRUNcyIwskmeRm02vT4pmiSkdWTE/FEC3GrsFZp2yac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744878555; c=relaxed/simple;
	bh=xVEfxsLo9pbqU1AK5jwlmJw5GMJsAlZuVl9sZWvfyvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yf6ClDHXFKCCHnPVPfx0/l4O8Bj+/ijEsNmSPh+P5bB1UhI+n7r12UVsfJfvOpYzKTaERtkSpEAdUX/g070w0vvG35JWDmRo+1V9m+rXlWoXYf2DHFsuuT1hCXCuwG5DFRTP/EfgO7Nt214BEVHSftO4hKNQoz75VK722JQovW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cEps0R6N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cEps0R6N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744878552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZkUrbKRD3U8etAppRrC1TENp5/BjAdyMh2DRgi3zpr4=;
	b=cEps0R6NFnPHgMypU7yOnxuy0FyV7Sm6EgMO0Sd2mElp76tiiki/0Of5WBJQg6kIbuFgBI
	0fRdGgH0fsnS2G7vxc2H/ODoGhcdjTk3RcDwEfjC3fbWY+uCsrgECFsZUxAI7kbKtqh2ku
	i741cWu0gL3w9twtmHQRxmS7UH6cYXw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-oIT_mvUIM1WWCH8FgVWbqQ-1; Thu, 17 Apr 2025 04:29:09 -0400
X-MC-Unique: oIT_mvUIM1WWCH8FgVWbqQ-1
X-Mimecast-MFC-AGG-ID: oIT_mvUIM1WWCH8FgVWbqQ_1744878549
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e8f9450b19so11235126d6.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 17 Apr 2025 01:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744878549; x=1745483349;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkUrbKRD3U8etAppRrC1TENp5/BjAdyMh2DRgi3zpr4=;
        b=rLQ937kKn7spZ/vcfgHCdSjgROViKdcpXQ+Q1YnRR8iPv24+q+kyQ+Suyn43wg/i2X
         goUjjMkKbY1KmgXhqE6dZzTT5HvgllJXFH+qB8U+Fjilq1owbZ40bR8TzwimS/dI+amp
         EDYSIZ3wWZZk6Lng3IXBBf/I91qRetLklpqb/zCCV+JrtcwNbuUP64jyVPwA4t1/u8D7
         zqjBxYwKVj/Fkj7URh6XMtGkPTolxtlT4GdL8blChvi8JkEz/OfDtBblwozhTERTY3M8
         f2i2HboHVH7ZQSGrfbkF2a2V+Ae7ECwRxNyEPCOU1IsGjYlJYnedV651bYOmOVQ5PpYC
         ML6A==
X-Forwarded-Encrypted: i=1; AJvYcCVxnB2UaHnNgUpkcp0jI53hAJyAr1lJVe7HNTQ9VKL0drH9Y4PEI4az1NsXuvEaG8cLT1cBAM0O8u3aoOc1cQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCtPmvZ+dvKv4rWiMm1W1Dr9CRaQF0vvomUxDuk975x+J+UHvq
	RRb1iIW/9jNWWeUj7U2vSSkjU0DnYrEL0G37X7KVXpGLzEX7oKKQGe9SeF03E2O6Cu3GDgV4D2+
	3/OkPwRY02i59n7LeEnoRXSyEbe5Gss4V2AfBC7KAiDlLdrCbXm56CixpjpTqYc+k
X-Gm-Gg: ASbGncs9PZiXHf/qMmZAmSYFUtwtRXpP9bds39tG9iNEWiee/ScTSMTuyl+mxRsHECx
	WPjVkgKbykr8+cnxzMimjH0GW8bCdlewgCdyOaeG0JlzsIQPZ0awf/HNvlHzaGVEUpNXpE4ppcF
	zoSdeoIQLblTgwwJFC2xnXNsstYW6r0csRU/y2tpsD026mZ6Lgls/fN2KPANl1kkVYruccd+wL5
	Y04SP4higg6VkdnHF5sK/9N3reJ+f3WlTH/FkfqOvDELmOdEARiV9E/rt2F5hUA/Jwxtq56Vy6z
	+LQWwH/c7/+WZ3rYfdQ5lysRWXttaSrv+h4fGe1dWg==
X-Received: by 2002:a05:6214:2a4a:b0:6e8:f296:5f57 with SMTP id 6a1803df08f44-6f2ba752e56mr28603416d6.20.1744878548836;
        Thu, 17 Apr 2025 01:29:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtQF2zq6rrDcP6LA8Xtwny4b0RzN0ztGrqa6EZLJoEKOG5SlAjk2oDTB+wONOtDKuoBS/asA==
X-Received: by 2002:a05:6214:2a4a:b0:6e8:f296:5f57 with SMTP id 6a1803df08f44-6f2ba752e56mr28603176d6.20.1744878548565;
        Thu, 17 Apr 2025 01:29:08 -0700 (PDT)
Received: from [192.168.88.253] (146-241-55-253.dyn.eolo.it. [146.241.55.253])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2a5856350sm34464696d6.97.2025.04.17.01.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 01:29:08 -0700 (PDT)
Message-ID: <75e10631-00a3-405a-b4d8-96b422ffbe41@redhat.com>
Date: Thu, 17 Apr 2025 10:29:05 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 13/18] net/sched: act_mirred: Move the
 recursion counter struct netdev_xmit
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>
References: <20250414160754.503321-1-bigeasy@linutronix.de>
 <20250414160754.503321-14-bigeasy@linutronix.de>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250414160754.503321-14-bigeasy@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yo9wa8T6AGRqsVf7_fFyC2J2e3tKU1eZ6dbD2GTEuL4_1744878549
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/25 6:07 PM, Sebastian Andrzej Siewior wrote:
> mirred_nest_level is a per-CPU variable and relies on disabled BH for its
> locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
> this data structure requires explicit locking.
> 
> Move mirred_nest_level to struct netdev_xmit as u8, provide wrappers.
> 
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/netdevice_xmit.h |  3 +++
>  net/sched/act_mirred.c         | 28 +++++++++++++++++++++++++---
>  2 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/netdevice_xmit.h b/include/linux/netdevice_xmit.h
> index 3bbbc1a9860a3..4793ec42b1faa 100644
> --- a/include/linux/netdevice_xmit.h
> +++ b/include/linux/netdevice_xmit.h
> @@ -11,6 +11,9 @@ struct netdev_xmit {
>  #if IS_ENABLED(CONFIG_NF_DUP_NETDEV)
>  	u8 nf_dup_skb_recursion;
>  #endif
> +#if IS_ENABLED(CONFIG_NET_ACT_MIRRED)
> +	u8 sched_mirred_nest;
> +#endif
>  };

How many of such recursion counters do you foresee will be needed?

AFAICS this one does not fit the existing hole anymore; the binary
layout before this series is:

 struct netdev_xmit {
                /* typedef u16 -> __u16 */ short unsigned int recursion;
                /*  2442     2 */
                /* typedef u8 -> __u8 */ unsigned char      more;
                /*  2444     1 */
                /* typedef u8 -> __u8 */ unsigned char
skip_txqueue;                /*  2445     1 */
        } net_xmit; /*  2442     4 */

        /* XXX 2 bytes hole, try to pack */

and this series already added 2 u8 fields. Since all the recursion
counters could be represented with less than 8 bits, perhaps using a
bitfield here could be worthy?!?

In any case I think we need explicit ack from the sched people.

> diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> index 5b38143659249..5f01f567c934d 100644
> --- a/net/sched/act_mirred.c
> +++ b/net/sched/act_mirred.c
> @@ -30,7 +30,29 @@ static LIST_HEAD(mirred_list);
>  static DEFINE_SPINLOCK(mirred_list_lock);
>  
>  #define MIRRED_NEST_LIMIT    4
> -static DEFINE_PER_CPU(unsigned int, mirred_nest_level);
> +
> +#ifndef CONFIG_PREEMPT_RT
> +static u8 tcf_mirred_nest_level_inc_return(void)
> +{
> +	return __this_cpu_inc_return(softnet_data.xmit.sched_mirred_nest);
> +}
> +
> +static void tcf_mirred_nest_level_dec(void)
> +{
> +	__this_cpu_dec(softnet_data.xmit.sched_mirred_nest);
> +}
> +
> +#else
> +static u8 tcf_mirred_nest_level_inc_return(void)
> +{
> +	return current->net_xmit.sched_mirred_nest++;
> +}
> +
> +static void tcf_mirred_nest_level_dec(void)
> +{
> +	current->net_xmit.sched_mirred_nest--;
> +}
> +#endif

There are already a few of this construct. Perhaps it would be worthy to
implement a netdev_xmit() helper returning a ptr to the whole struct and
use it to reduce the number of #ifdef

Thanks,

Paolo


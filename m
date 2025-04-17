Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2331226548
	for <linux-rt-devel@lists.linux.dev>; Thu, 17 Apr 2025 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883295; cv=none; b=TkEpQG/rIN7mGTNQyh0W48BZBHErWQrara8p3cAddtvsHPvW47hOsRz3ehcpaF4QCaE2dc/PlRkSYAEOszBjtiYh9vnD0y3g25+CScEc8Ty6u1YXhQdaUY+oWxTH0d/8NFN6ao5OJV7mJ9sFI6hoO8XZaolBDK1fG0J5sKGUDIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883295; c=relaxed/simple;
	bh=/aHET5kZKvLdkox/3VQPga2z8hoW/sDglTDP1G290yU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tt516e/RRsmMjpWYd9KKW4LVcHx8Xwuh0tESXJ1yBbrhozl7T4Kfpi0TvVWaG4a2/wyH0IGNu0CnAmX0+L1MgpJyFr4DSs5mBWvgK7S7fmMgEdkedKxl2ATDnDwQcFTO90tB4VPNEhpCIAU+C4hZFtjAwZTy8bU3cUr6q+ttDSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SbdcoUP+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SbdcoUP+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744883291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YKSRN7Y1CSOmPsR55ndAShefoLbgMNdj/tzKyeXbOo=;
	b=SbdcoUP+qPS5aya3nVhOcy256glv1uwwdo3b9jpgYVy9uF0wLPUv2fsAJD23XLobK38UG8
	TuGeEugKYsDJLktxYNvQajKYvgUUoPquG74YtEwGDFLW9sU4HT19Tak89wzk+66TXd0cEk
	2YVQJV3t+8xIe3zzPDMgs+42pvG7Wvo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-X3hui3gaNNu87vE6OKzg0w-1; Thu, 17 Apr 2025 05:48:10 -0400
X-MC-Unique: X3hui3gaNNu87vE6OKzg0w-1
X-Mimecast-MFC-AGG-ID: X3hui3gaNNu87vE6OKzg0w_1744883289
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d4d15058dso4985285e9.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 17 Apr 2025 02:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744883289; x=1745488089;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0YKSRN7Y1CSOmPsR55ndAShefoLbgMNdj/tzKyeXbOo=;
        b=dZgRAyv+UZZaYPirHEYpwx17p/A52OxY6O/hK2H9bNRdes50XYuWPHreGujnQPf7z7
         tU4WICaAGO/bQwZiIq1yy+MBfzblLn5Mcv6WwHBPu/e4EtRVT/4XJx8i1oqQ7ZPHBwvh
         t+/LGc5BGIUcA6+nHyZnbNMjsYIcIMOcdsJFwa1W6PHUGTYYhaXktQ0a1TFCwYF7e3Qo
         Azc/Ufk14wcJBiDZfkkdDoJ6jnh7xewocDCqFc+Pzj5DMYDp3CNv0Q7mVQRnvsJNA5LR
         hEAAHCJ8gaRelHcIqcNGK6cqeZazqiNm3B3+yza74vJaB75oHjyXDu+P+yLzF9BM8/Rh
         TKJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3VWeIwC7wCxEXnj9xzuZhAx2ETqJUqGsszUiPdXcqmjKnxEy5AeQKOWJc2EXZBLQ46mofDFLJMi/o5B3KjA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9RfvHcBv92Mh5BgISj4YHF4FYvy/NTvz4fae8gSN5Kvsj1ls+
	t9y9LO2iWCBc8oQ7qI03m50M6qUVSRSyTWQZINZIjpNgO2N8VQ3rJpOMSB/7oYC/eSosXLld20z
	HQb6ONA7LxssYm/rur86AUoAZnseiYKuayzCfa3/cLQsSfhGFpSZD6VcamVh785+3
X-Gm-Gg: ASbGnctpZskTBGfEMf0k2Be3TBK0hr+7IsbdXxzUB4xEkOt2vaSC0rCR4wB3vQcPcj7
	Bga6SXH8SbDPGeIdi7v8snvfvrtndjY5qGfZcMV94fAR/oGX3uu2JkYTLBc/NND64uvA8eJGxp6
	kNEkyglTZlipKTiFylpaW2Sk63xgBlJLk10izN83WqGyykjmP5wHUSW0H76TN07c5fQC1Vy4qLl
	3DE+ZBjNEK3Qdu9khqZbpJpMcAk1hy4eFBMtXQUNsDkgI2Q8ZCga1XfMVDcPJ7I/9naFVbg0Mw6
	xsfOWWayaXEUl/poG7h1COTawhuvFUDwyT5xWjBkGw==
X-Received: by 2002:a05:600c:a15:b0:43c:fb95:c76f with SMTP id 5b1f17b1804b1-4405d61ce41mr54456715e9.9.1744883288987;
        Thu, 17 Apr 2025 02:48:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLDK3NSaV4N4d3HAevD3oTSYRJ2ZVpwnswgN3/kRFztBAp62+ivbgG75Xh2sCTm/nE3qRRBw==
X-Received: by 2002:a05:600c:a15:b0:43c:fb95:c76f with SMTP id 5b1f17b1804b1-4405d61ce41mr54454955e9.9.1744883285195;
        Thu, 17 Apr 2025 02:48:05 -0700 (PDT)
Received: from [192.168.88.253] (146-241-55-253.dyn.eolo.it. [146.241.55.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b50b964sm47241655e9.27.2025.04.17.02.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 02:48:04 -0700 (PDT)
Message-ID: <94076638-1bc7-4408-b09c-7c51f995d36f@redhat.com>
Date: Thu, 17 Apr 2025 11:48:03 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 12/18] openvswitch: Move ovs_frag_data_storage
 into the struct ovs_pcpu_storage
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 dev@openvswitch.org
References: <20250414160754.503321-1-bigeasy@linutronix.de>
 <20250414160754.503321-13-bigeasy@linutronix.de> <f7tbjsxfl22.fsf@redhat.com>
 <20250416164509.FOo_r2m1@linutronix.de>
 <867bb4b6-df27-4948-ab51-9dcc11c04064@redhat.com>
 <20250417090810.ps1WZHQQ@linutronix.de>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250417090810.ps1WZHQQ@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xL_oWtFona2iLeXu92I6p4mGRnzcrsI3lcj11XK3CEQ_1744883289
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/17/25 11:08 AM, Sebastian Andrzej Siewior wrote:
> On 2025-04-17 10:01:17 [+0200], Paolo Abeni wrote:
>> @Sebastian: I think the 'owner' assignment could be optimized out at
>> compile time for non RT build - will likely not matter for performances,
>> but I think it will be 'nicer', could you please update the patches to
>> do that?
> 
> If we don't assign the `owner' then we can't use the lock even on !RT
> because lockdep should complain. What about this then:
> 
> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> index a3989d450a67f..b8f766978466d 100644
> --- a/net/openvswitch/datapath.c
> +++ b/net/openvswitch/datapath.c
> @@ -294,8 +294,11 @@ void ovs_dp_process_packet(struct sk_buff *skb, struct sw_flow_key *key)
>  	sf_acts = rcu_dereference(flow->sf_acts);
>  	/* This path can be invoked recursively: Use the current task to
>  	 * identify recursive invocation - the lock must be acquired only once.
> +	 * Even with disabled bottom halves this can be preempted on PREEMPT_RT.
> +	 * Limit the provecc to RT to avoid assigning `owner' if it can be
> +	 * avoided.
>  	 */
> -	if (ovs_pcpu->owner != current) {
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && ovs_pcpu->owner != current) {
>  		local_lock_nested_bh(&ovs_pcpu_storage.bh_lock);
>  		ovs_pcpu->owner = current;
>  		ovs_pcpu_locked = true;
> @@ -687,9 +690,11 @@ static int ovs_packet_cmd_execute(struct sk_buff *skb, struct genl_info *info)
>  
>  	local_bh_disable();
>  	local_lock_nested_bh(&ovs_pcpu_storage.bh_lock);
> -	this_cpu_write(ovs_pcpu_storage.owner, current);
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		this_cpu_write(ovs_pcpu_storage.owner, current);

Perhaps implement the above 2 lines in an helper, to keep the code tidy?
otherwise LGTM.

Thanks,

Paolo


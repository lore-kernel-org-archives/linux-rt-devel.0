Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890E421B191
	for <linux-rt-devel@lists.linux.dev>; Tue, 22 Jul 2025 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172898; cv=none; b=ErvSuFLGS5jQcbh3iXPNefnwSO3yXlJoKCmcaMo10utWTWTWt0C7iY/0hH5RiW0oNuPb426IPlE6URBk/zNKU13Dgz51INbvkyLO0JBKqp4yeXGEYkC1Vv2Rb2nBV4IIInIm5ytM9vyVsibVFiwvMN5ts7Q8yfejc0KWtDjoAHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172898; c=relaxed/simple;
	bh=cykTOngrnbCr//Kc9KMRHa+O2/mlQEXw/ntI6485ZGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tdX1YXDK/63DmcebCRiOw+heLi81nm6hKhddWG11m3xDi6udQzCwaBX/VjU0LvXOUDZPMLHGqgo2ph4GEpBq/m1mewR+rO6s4EZX2WdMnzCCqW1QmUyAPTM62GmkJZkQ63/JNCDzU02hVtQwfPDjAC6WC0W1cmAOpRCkCmOJgVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Message-ID: <60257b86-bba4-4f52-a5e4-1e4caeb3412f@lankhorst.se>
Date: Tue, 22 Jul 2025 10:28:06 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Remove lockdep_assert_irqs_disabled()
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
 Maciej Falkowski <maciej.falkowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20250715165919.33754-1-dev@lankhorst.se>
 <f14e9187-e3b1-494d-b04f-9e7875a17e5a@linux.intel.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <f14e9187-e3b1-494d-b04f-9e7875a17e5a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hey,

Den 2025-07-22 kl. 09:53, skrev Jacek Lawrynowicz:
> Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

Thanks, pushed to misc-next.

Best regards,
~Maarten
 
> On 7/15/2025 6:59 PM, Maarten Lankhorst wrote:
>> This breaks on PREEMPT_RT, and should be unneeded since
>> lockdep can track irq disabled status itself.
>>
>> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
>> ---
>>  drivers/accel/ivpu/ivpu_ipc.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
>> index 39f83225c1815..5f00809d448af 100644
>> --- a/drivers/accel/ivpu/ivpu_ipc.c
>> +++ b/drivers/accel/ivpu/ivpu_ipc.c
>> @@ -141,7 +141,6 @@ ivpu_ipc_rx_msg_add(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
>>  	struct ivpu_ipc_rx_msg *rx_msg;
>>  
>>  	lockdep_assert_held(&ipc->cons_lock);
>> -	lockdep_assert_irqs_disabled();
>>  
>>  	rx_msg = kzalloc(sizeof(*rx_msg), GFP_ATOMIC);
>>  	if (!rx_msg) {
> 


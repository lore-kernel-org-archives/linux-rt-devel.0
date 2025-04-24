Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB6C221278
	for <linux-rt-devel@lists.linux.dev>; Thu, 24 Apr 2025 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479857; cv=none; b=qMYMzF/6/mdUUoD3CwOhg8/Uuz4C7FpuNvEpYYYbCDbPWFVoWX/Kmz2045DsQGrPo4faiU1qeE2hukA5EvvxMES1VcNPjwsNrpZM9GDidUXhPplmbeRoQHYPvnTp2qEAkLCkszdS2hDYe036CxYvzgfMyljd9LIn3MO0SmtGdrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479857; c=relaxed/simple;
	bh=Yqw2vfhhpRsy+rECEl7DVl3puCqPe4a8UIiVe6FSIO4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t3GsJPNahDi3aLtyHMLQ/mbiQBvOnXtgr7zoOGKSR/R0rFRQcHAG1d+kwQ5s0U2BDOBFR+/zUqq2JVduyKj/ktMRa4Av9nFf5AZ+hwOUW8SVBabPHIEG/vJ4Qkk7tMT28Qxdx58Zd3HXdWsYjXzz9TR8zL2gsom+ViIrqv8L1UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bKHYEG/W; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bKHYEG/W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745479856; x=1777015856;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Yqw2vfhhpRsy+rECEl7DVl3puCqPe4a8UIiVe6FSIO4=;
  b=bKHYEG/W9wyqU2E/Ni8FYUHpOAgmzHSrCXhDAa9qwOv36Vf1pqJ1PGLo
   ARtO+QQr6ksSw8LbpDrIpTKFaNEYGLFMsMbPY4rP1c5dMwVKPJp/h7TQz
   v0JgpzikIDKB4vaZfljL5l3EVmfCG4tlikIPOm1AYPVkqHCfPLM+md3aU
   Jy7tTe/tNz3SnibTSaJLXqEKafGgQCaT9v4Mji5TmYDLfE8MpriY99lvr
   QO9X9nsUvLCegfiU71vF2CoXubnIr2lYN4tgcINSMb9oDte9MK/gCHCYg
   stcpbd+A1h4dSqxWFZdPR4Jvxo053VZ6uQADzdv0oSXPjoIqnooqBz70R
   A==;
X-CSE-ConnectionGUID: G7N9Iha5QdC3hG3czqPtBw==
X-CSE-MsgGUID: ykegb19dT5CftesECWmyNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="64510583"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="64510583"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 00:30:55 -0700
X-CSE-ConnectionGUID: Z/ypjmu4Tzy++aj7ce+k7g==
X-CSE-MsgGUID: HiLuNSIdSeCcq5hltUSTdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="137709000"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.243])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 00:30:51 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Junxiao Chang
 <junxiao.chang@intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Clark
 Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] drm/i915/gsc: mei interrupt top half should be in irq
 disabled context
In-Reply-To: <20250424071553.yT9-dWWM@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250424065609.624457-1-junxiao.chang@intel.com>
 <20250424071553.yT9-dWWM@linutronix.de>
Date: Thu, 24 Apr 2025 10:30:47 +0300
Message-ID: <87zfg6yq1k.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 24 Apr 2025, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> On 2025-04-24 14:56:08 [+0800], Junxiao Chang wrote:
>> MEI GSC interrupt comes from i915. It has top half and bottom half.
>> Top half is called from i915 interrupt handler. It should be in
>> irq disabled context.
>> 
>> With RT kernel, by default i915 IRQ handler is in threaded IRQ. MEI GSC
>> top half might be in threaded IRQ context. In this case, local IRQ
>> should be disabled for MEI GSC interrupt top half.
>> 
>> This change fixes A380/A770 GPU boot hang issue with RT kernel.
>
> This should have a Fixes when generic_handle_irq() was introduced. 
>
>> Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
>> ---
>>  drivers/gpu/drm/i915/gt/intel_gsc.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>> 
>> diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.c b/drivers/gpu/drm/i915/gt/intel_gsc.c
>> index 1e925c75fb080..9c72117263f78 100644
>> --- a/drivers/gpu/drm/i915/gt/intel_gsc.c
>> +++ b/drivers/gpu/drm/i915/gt/intel_gsc.c
>> @@ -270,6 +270,9 @@ static void gsc_init_one(struct drm_i915_private *i915, struct intel_gsc *gsc,
>>  static void gsc_irq_handler(struct intel_gt *gt, unsigned int intf_id)
>>  {
>>  	int ret;
>> +#ifdef CONFIG_PREEMPT_RT
>> +	int irq_disabled_flag;
>> +#endif
>>  
>>  	if (intf_id >= INTEL_GSC_NUM_INTERFACES) {
>>  		gt_warn_once(gt, "GSC irq: intf_id %d is out of range", intf_id);
>> @@ -284,7 +287,18 @@ static void gsc_irq_handler(struct intel_gt *gt, unsigned int intf_id)
>>  	if (gt->gsc.intf[intf_id].irq < 0)
>>  		return;
>>  
>> +#ifdef CONFIG_PREEMPT_RT
>> +	/* mei interrupt top half should run in irq disabled context */
>> +	irq_disabled_flag = irqs_disabled();
>> +	if (!irq_disabled_flag)
>> +		local_irq_disable();
>> +#endif
>>  	ret = generic_handle_irq(gt->gsc.intf[intf_id].irq);
>
> What about generic_handle_irq_safe() instead the whole ifdef show?

Anything without the ifdefs would be welcome.

BR,
Jani.

>
>> +#ifdef CONFIG_PREEMPT_RT
>> +	if (!irq_disabled_flag)
>> +		local_irq_enable();
>> +#endif
>> +
>>  	if (ret)
>>  		gt_err_ratelimited(gt, "error handling GSC irq: %d\n", ret);
>>  }
>
> Sebastian

-- 
Jani Nikula, Intel

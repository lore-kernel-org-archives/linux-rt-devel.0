Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3488C30E835
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Jul 2026 18:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783102859; cv=none; b=Ujirp3E/uegPdLCwlyQu3lV39qJZ8cxN5AdLLL/EJfUTb8krJxhzLPoItSqGBvl36tzyx30oGlH0Iovvzah1gtud9cha5LrAaramSwMRzGfGqO+VSr7eEGLuUJYD4d0doBnSojZeOoPNNP45wEr5Ezr59x0S4nSINgUptkUc2FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783102859; c=relaxed/simple;
	bh=3qQ9/mjbBV0K3iPIIclALgfH80hz48pXIy2Z2lLLPvQ=;
	h=From:Content-Type:Mime-Version:Subject:Date:References:To:
	 In-Reply-To:Message-Id; b=SvNddepvWRocHAgfrpdHpznjP7OdHM0650hUGk6V7V9Lo2D57WEmsWz2+WIM8NjhJH9MlRVRnNxH7EA51LgSSIu7Ouj6ZWqmfkRFo3wgRmZyY090tx8mTWqf4jKL4swG5yJiIgcfyem0Zzc9VflYT3AZoNit0m1hNBH7izIbmys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=by-online.de; spf=pass smtp.mailfrom=by-online.de; dkim=pass (2048-bit key) header.d=by-online.de header.i=by@by-online.de header.b=DYcl2kcF; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=by-online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=by-online.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=by-online.de header.i=by@by-online.de header.b="DYcl2kcF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=by-online.de;
	s=s1-ionos; t=1783102843; x=1783707643; i=by@by-online.de;
	bh=nhsV+0TML8YUajKnCXZrqWuKyCnJ6VhazWS9XSvqpUg=;
	h=X-UI-Sender-Class:From:Content-Type:Content-Transfer-Encoding:
	 Mime-Version:Subject:Date:References:To:In-Reply-To:Message-Id:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DYcl2kcFEgepBpNXukCSx7RVRT9u5jor662Vy04ZBBNgHzrXeeM4VfVI9oG6JMnr
	 +vp3SxNjf2sWglfilJfSaXgYFd6dBbf6c/jBFyrEpU+7RUopgi5b4s+2CAMnGbqVg
	 wqP9vnpciHGGpKlUG1D/K+UuLe8woAOviaJezVsxLzXFvcy7W5uJmrKT876fSYqU8
	 0MpY4Jl8T5rVzjpuqlnlpodVk4Pxk+I3hOjjD5k6ss49JZeO04VzlNDSTV27IK+Il
	 oyhhd0PuD60RCbEjoalJM+QRCQoGMqrVDStnUZDb0vnpe8LXMjwxE56KuRxBu2JmT
	 APNFQIBdWLJMagpj/w==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue109
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N8GIg-1xAG0B1cYa-00wKIj; Fri, 03
 Jul 2026 20:20:43 +0200
From: Michael Byczkowski <by@by-online.de>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH v7 1/1] pps: pps-gpio: split IRQ handler into hardirq
 timestamper + threaded handler
Date: Fri, 3 Jul 2026 20:20:31 +0200
References: <cover.1780359378.git.calvin@wbinvd.org>
 <2e32729029fbf6977ecf04665eb00f2efd3e2c17.1780359378.git.calvin@wbinvd.org>
 <20260602063650.LWatIBPk@linutronix.de>
 <79BC1B96-FD2C-4191-8766-6C46BF8A1089@by-online.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Calvin Owens <calvin@wbinvd.org>,
 linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev,
 Rodolfo Giometti <giometti@enneenne.com>,
 Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Eliav Farber <farbere@amazon.com>,
 Ingo Molnar <mingo@kernel.org>,
 David Laight <david.laight.linux@gmail.com>,
 Thomas Gleixner <tglx@kernel.org>
In-Reply-To: <79BC1B96-FD2C-4191-8766-6C46BF8A1089@by-online.de>
Message-Id: <F4693DE2-E36F-4157-BB7B-A98A7C1C76E3@by-online.de>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-Provags-ID: V03:K1:rWivulpxvoPrlAbBdDlOiAkZIWq8h8l6Qi9W6FHC/evBe7lbush
 57GgQ6BCdYxgFmY0cwdu4dYILXVvExnhPYoGhsFdJtbG7WcTZ4qYGc5zC7mb+KVkNzu4vue
 0Z9sgcq5awWZBmAa6Kl+cuB0OyS6b5ulTm8Zit1Qbx/7xOFIzI+7wt72yoL6+d3bxkewsC8
 cx9XPbbUbSe/Koyxy5XYA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SW0YrZ6MyuI=;Jm4GU/unD3LADzwghj6kWIPDtBc
 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
 zB3+lOPzOqx9ODCz+BAMHYHhx2Aro=

Dear All,

Now that 7.2-rc1 is out and this didn't make the merge window, could =
someone please confirm which tree will carry this for 7.3?
So far, the patch has been:
    =E2=80=A2 Reviewed-by: Sebastian Andrzej Siewior (Jun 2)
    =E2=80=A2 Acked-by: Rodolfo Giometti (PPS maintainer, from earlier =
revisions)
    =E2=80=A2 Tested-by from Calvin Owens and myself

I'm not sure whether it should go via drivers/pps (Rodolfo), the rt =
tree, or -mm. Happy to help route it wherever makes sense.
lore: =
https://lore.kernel.org/lkml/79BC1B96-FD2C-4191-8766-6C46BF8A1089@by-onlin=
e.de/

Thank you very much and best regards,
Michael



> On 3. Jun 2026, at 19:29, Michael Byczkowski <by@by-online.de> wrote:
>=20
> Thank you Sebastian, and thank you Calvin for relaying. I appreciate =
the
> thorough review that got this to the right shape.
>=20
> Best regards,
> Michael
>=20
>=20
>> On 2. Jun 2026, at 08:36, Sebastian Andrzej Siewior =
<bigeasy@linutronix.de> wrote:
>>=20
>> On 2026-06-01 17:44:09 [-0700], Calvin Owens wrote:
>>> From: Michael Byczkowski <by@by-online.de>
>>>=20
>>> Split the pps-gpio interrupt handler into a primary (hardirq) =
handler
>>> that captures the PPS timestamp at interrupt entry, and a threaded
>>> handler that processes the event. This produces the same two-part
>>> handler structure on both PREEMPT_RT and non-RT kernels.
>>>=20
>>> On non-RT kernels the threaded portion runs immediately after the
>>> primary, with no behavioral change compared to the previous
>>> single-handler implementation.
>>>=20
>>> On PREEMPT_RT, where interrupt handlers are force-threaded by =
default,
>>> the previous single-handler implementation captured the timestamp
>>> inside the threaded portion, after IRQ-thread scheduling delay. With
>>> the split, the timestamp is captured in true hardirq context as it =
is
>>> on non-RT kernels, eliminating a significant source of PPS jitter on
>>> RT systems.
>>>=20
>>> Tested-by: Michael Byczkowski <by@by-online.de>
>>> Tested-by: Calvin Owens <calvin@wbinvd.org>
>>> Acked-by: Rodolfo Giometti <giometti@enneenne.com>
>>> Signed-off-by: Michael Byczkowski <by@by-online.de>
>>> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
>>> ---
>>=20
>> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>=20
>> Sebastian
>=20


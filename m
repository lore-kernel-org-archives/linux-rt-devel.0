Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795680981;
	b=SsN3QD9uXZ8S8MpP6fpsciCKAT+SNjDJU2Z3VdCYpfSYDmQ7AarZeN0z0C9dlXeAkbwv
	 xhD03+/UHxwMqndNWcto972BWCKCpNxpqTq3Jr2/Ke6gOfht1owC0Q0oftBv16eBpGbNs
	 qckmOZmOmEcECtE7bsAuNk7YGTxLuVpGwvkQEC3oUNLP8DGD2MWAumKfATwoBjjlmgMIB
	 Ug2C4ZM2CXpMRAwkK3SdE2E6sG5lKT71hdiYLbT6khX5Sj3/iyliDQV0srsBDcH2N4zej
	 e0dtQgZraDEbCZYWcztb2L/y737Ig6YjZKdYKRMfdmS57A3JFZSWI9GMl6nPFVTfDVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680981;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=JGQ6rQ9KjgTLE7XKHXoqOXReY5Cx5tSHHb2hfYg3jtk=;
	b=TzqolLE7pXGWd10QLJGX/U6+hrncG4y7qPkgVwlecXhdek6n0g/e1ZRAzKETizap9QZn
	 NmbsF7MD1R4zDIaJ/Os8Fc5hBa+h0abmtKOF9koR973g01oOCg/SCfgEzcYxoWEkD6pvk
	 PW4p2Oafng3TOJRPTHZo5Al8BMXZ/8nLNIqfq10jsXGPcYPngZegvPrBMfx7cMZxE5L2n
	 kHHG7vWhVnxgwEpJ31JL9g6N3M8/GPINroRqYMdk0xZfhQKYA1FjbFxFZcpYpsMYhNwIu
	 XJEHobSKcE8gOGd2Q+k92K0Ulsk0uQV/wZjjAioEZ9CCjDzF1MVkFY/BECx8P6Yomjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Q0xDfG4z;
	arc=none smtp.remote-ip=95.215.58.211
Received: from mta1.migadu.com (out-211.mta1.migadu.com [95.215.58.211])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D49606A31E
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Nov 2026 08:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7D49606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Q0xDfG4z
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=2tapKyPOWs6voUGnssNqs09oXMxfImVb3hhu9BetUwA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795680977; v=1; x=1796285777;
 b=Q0xDfG4zYhDln0rpnHjWfvvKbPYnx353oO5zc59YANx7nucwDWqnSRabK0S668EM2NLmLnrJ
 /1HbnU+OirGUdFWFakPR5E2arECH7edydUeckwzPSpZ9kS1o7wBEov9tP8OLVB2csf+OtqNOfkE
 jnklgkhsySWJgRYbbpU2XUIs=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 409d69e45079a162;
	Thu, 26 Nov 2026 08:16:17 +0000
X-Mizu-Trace-ID: 409d69e45079a162
X-Migadu-Flow: FLOW_OUT
Date: Thu, 26 Nov 2026 16:16:10 +0800
From: Peng Fan <peng.fan@linux.dev>
To: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peng Fan <peng.fan@oss.nxp.com>, Peng Fan <peng.fan@nxp.com>,
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev,
	Bjorn Andersson <andersson@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 00/10] mailbox: imx: Use threaded handler to avoid
 kworker in imx's remoteproc
Message-ID: <awfqyvcwtK5Hi8j0@fedora>
References: <av6Wc+kHFKqwFHAR@shlinux89>
 <20261116102331.K8Sc86V9@linutronix.de>
 <20261119114041.GA166708@francesco-nb>
 <av8H7l6C8fmiHdbV@fedora>
 <av8LQa77SbshHmZD@francesco-nb>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <av8LQa77SbshHmZD@francesco-nb>

Hi Francesco,

On Thu, Nov 19, 2026 at 03:44:17PM +0100, Francesco Dolcini wrote:
>On Thu, Nov 19, 2026 at 10:30:06PM +0800, Peng Fan wrote:
>> On Thu, Nov 19, 2026 at 12:40:41PM +0100, Francesco Dolcini wrote:
>> >Hello Peng, Sebastian
>> >
>> >On Mon, Nov 16, 2026 at 11:23:31AM +0100, Sebastian Andrzej Siewior wrote:
>> >> On 2026-11-16 10:23:41 [+0100], Francesco Dolcini wrote:
>> >> > Our CI shows a ~10-15% eMMC sequential read throughput drop on i.MX8QXP
>> >> > and i.MX8DX (Colibri iMX8X, Cortex-A35), starting with v7.2-rc1 and
>> >> > still present in v7.4-rc3 (hdparm --direct -t: ~129 MB/s -> 105-120
>> >> > MB/s on i.MX8DX). i.MX8QM, i.MX8M and i.MX9 are not affected.
>> >> > 
>> >> > 5d1c0000.mailbox interrupt count before the test went from ~8k on v6.18
>> >> > to 60k+ on v7.3/v7.4.
>> >> > 
>> >> > Peng: any idea/suggestion? Does it makes any sense to you?
>> >> 
>> >> Can you pin point it to a patch in this series? My guess is that
>> >> something with the masking/ unmasking went wrong. The increase might be
>> >> result of the interrupt keeping firing while the threaded interrupt did
>> >> not have a chance to run.
>> >
>> >Reverting 36cac4b5101f, 3225a745f517, e55bea377d49 and 692e1bc96a5d
>> >restores 149 MB/s with schedutil.
>> >
>> >
>> >On Thu, Nov 19, 2026 at 02:25:55PM +0800, Peng Fan wrote:
>> >> On Mon, Nov 16, 2026 at 10:23:41AM +0100, Francesco Dolcini wrote:
>> >> >Peng: any idea/suggestion? Does it makes any sense to you?
>> >> 
>> >> Please help test whether this helps:
>> >> 
>> >> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
>> >> index 683ccea6f2ba..e29044cf4b92 100644
>> >> --- a/drivers/mailbox/imx-mailbox.c
>> >> +++ b/drivers/mailbox/imx-mailbox.c
>> >> @@ -635,7 +635,7 @@ static int imx_mu_startup(struct mbox_chan *chan)
>> >>  {
>> >>         struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
>> >>         struct imx_mu_con_priv *cp = chan->con_priv;
>> >> -       unsigned long irq_flag = IRQF_NO_THREAD;
>> >> +       unsigned long irq_flag = IRQF_NO_THREAD | IRQF_ONESHOT;
>> >>         int ret;
>> >> 
>> >>         pm_runtime_get_sync(priv->dev);
>> >
>> >It does not help.
>> >	
>> >The analysis below was done with Claude help, on measurements I took on a
>> >Colibri iMX8QXP. I hope you can pick it up from there, this is not my
>> >area of expertise, and the best I can do is to send a revert for those 4
>> >commits.
>> >
>> >Every SCU RPC now wakes the SCHED_FIFO irq thread (TX done and RX), and
>> >while an RT task is runnable schedutil requests the maximum CPU frequency.
>> >The A35 clock is CLK_GET_RATE_NOCACHE, so each frequency change is
>> >followed by an SCU RPC reading the rate back, which wakes the irq thread
>> >again. The loop never settles, even when idle, and the transitions (ATF +
>> >SCU) are what costs the eMMC throughput (and I assume there is more
>> >impact on performance than just this).
>> 
>> Not sure whether this is root cause, per my understanding, cpu freq update
>> is not that high frequency call.
>
>Moving to `performance` from `schedutil` or reverting those 4 patches
>solve the issue. And the significant increase on ctx switches and irq
>count is real even on idle without any emmc test running.
>
>> Let me setup a i.MX8QXP board and see what's going on there.
>Thanks!
>
>> BTW, i.MX8QM should
>> also have same issue, but seems not impact in your report, a bit werid,
>> might be because i.MX8QM has more cores :)
>
>I agree, I did not run any kind of extensive performance test. What
>happened is just that our emmc test started to fail, and this lead to
>this series. 
>
>> Have you tried pin your emmc test thread to core3, or core2, just not core0.
>
>It was never pinned to any core, so the scheduler decided on its own.
>And multiple runs of the test all lead to the same results.

My test on i.MX8QXP-MEK does not show interrupt increasing a lot, ignore the rootfs name.

root@imx91evk:~# cat /sys/bus/soc/devices/soc0/soc_id
i.MX8QXP
root@imx91evk:~# ./hdparm --direct -t /dev/mmcblk0

/dev/mmcblk0:
 Timing O_DIRECT disk reads: 646 MB in  3.00 seconds = 215.27 MB/sec
root@imx91evk:~# cat /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
schedutil
root@imx91evk:~# cat /proc/interrupts | grep mail
  14:       6922          0          0          0  GICv3     209 Level     5d1c0000.mailbox[0-0], 5d1c0000.mailbox[1-0], 5d1c0000.mailbox[3-3]
  35:          0          0          0          0  GICv3     216 Level     5d200000.mailbox[0-1], 5d200000.mailbox[1-1]
root@imx91evk:~# uname -a
Linux imx91evk 7.4.0-rc4-next-20261125 #6 SMP PREEMPT_DYNAMIC Thu Nov 26 06:56:40 CST 2026 aarch64 GNU/Linux
root@imx91evk:~#

root@imx91evk:~# cpufreq-set -g schedutil
root@imx91evk:~# cat /proc/interrupts | grep mail
  14:       6954          0          0          0  GICv3     209 Level     5d1c0000.mailbox[0-0], 5d1c0000.mailbox[1-0], 5d1c0000.mailbox[3-3]
  35:          0          0          0          0  GICv3     216 Level     5d200000.mailbox[0-1], 5d200000.mailbox[1-1]
root@imx91evk:~# ./hdparm --direct -t /dev/mmcblk0

/dev/mmcblk0:
 Timing O_DIRECT disk reads: 646 MB in  3.00 seconds = 215.24 MB/sec
root@imx91evk:~# cat /proc/interrupts | grep mail
  14:       6961          0          0          0  GICv3     209 Level     5d1c0000.mailbox[0-0], 5d1c0000.mailbox[1-0], 5d1c0000.mailbox[3-3]
  35:          0          0          0          0  GICv3     216 Level     5d200000.mailbox[0-1], 5d200000.mailbox[1-1]
root@imx91evk:~#


Regards
Peng

>
>Francesco
>
>

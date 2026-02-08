Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAF330BB94
	for <linux-rt-devel@lists.linux.dev>; Sun,  8 Feb 2026 02:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770516199; cv=none; b=sWeDYbSrPdl3YtWdYT5Xm5n7+aukRPcljM8Tq599OwYM+dvSptmD7eF16KkAVrvu+OzCxahYs3x1o0K4cB4ngtx5np4WQnOXx69T2EwLGA+wVQRSsKGKXmfsJftJQMMxG6WLi2YMGimApPUPeWn7Oqc2aBqa5S4Khhz0+aRDEBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770516199; c=relaxed/simple;
	bh=+fQ18929i8/mDv3yAtOFK4puWnm6K8HfQgu0fEGftbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EI2ZXrfnACEvxXpmph1VKkuW4M5GWPifNw1k2CDdzyplg8riB7h6nW+VzimPKit0goAccS5hdJiJN69Wg41t7z+f+pCH3/Gu8LWHxEhwAPDyAnctui2gu+118WaPxJFmb0WmpridgfoemGKEjXY/bCA1EF0RM5mSKxNANq67dsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CJbEcAHu; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CJbEcAHu"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6181jh0r2253497;
	Sun, 8 Feb 2026 02:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=g7Og7keEh/pJ2yfrKskvdx6Wx4krU0x8khEMKm8Du9w=; b=
	CJbEcAHuG0rZZB3CHePlb3RNbonpxzHS0MgQHE9TxnhFSGQRdSkVYSHOdpjnlezF
	JhX9BjNUw6so6XaFYM/MZSvgISqEsZ0FieS4EvQswzDfbTraWEGxGTz9w6uUxphT
	8qzX7quoIZghvBe1LbWlPcJ5WEA5tfNGrrdYyM0rUPXgGFVgNNzgIxns8uzttBo8
	uf4glzzd9H0COgn52Q6vk4TpjoCcctG/v2JcDL8F29+9dnDB1AV1hDYDzFBoxJcJ
	BsS3d2FZuocxtuVoy2ZMCvABQdlsHHu12qwR3KsAtPRi9+D6poreCKqF3zqgBNjP
	W86JWZz+s4MxhcMKlXYQ8g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xhu8hur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 08 Feb 2026 02:01:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 617JIW0q006566;
	Sun, 8 Feb 2026 02:01:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uubuk4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 08 Feb 2026 02:01:57 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61821sxO016745;
	Sun, 8 Feb 2026 02:01:56 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4c5uubuk3y-3;
	Sun, 08 Feb 2026 02:01:56 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-rt-devel@lists.linux.dev, Thomas Gleixner <tglx@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Amit Kucheria <amitk@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Lechner <dlechner@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Silva <gustavograzs@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jassi Brar <jassisinghbrar@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linusw@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Martin Tuma <martin.tuma@digiteqautomotive.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nishant Malpani <nish.malpani25@gmail.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Oder Chiou <oder_chiou@realtek.com>, Peter Huewe <peterhuewe@gmx.de>,
        Puranjay Mohan <puranjay@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Takashi Iwai <tiwai@suse.com>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Troy Mitchell <troy.mitchell@linux.spacemit.com>,
        Will Deacon <will@kernel.org>, Xianwei Zhao <xianwei.zhao@amlogic.com>,
        Yiting Deng <yiting.deng@amlogic.com>, Yixun Lan <dlan@gentoo.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: (subset) [PATCH 00/21] IRQF_ONESHOT clean up
Date: Sat,  7 Feb 2026 21:01:44 -0500
Message-ID: <177051564455.3805738.3731082521349211476.b4-ty@oracle.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260123113708.416727-1-bigeasy@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_01,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602080015
X-Proofpoint-GUID: TvVVSfDdZyD8iuHaFu82ujwIbS3Vq0YC
X-Authority-Analysis: v=2.4 cv=FIsWBuos c=1 sm=1 tr=0 ts=6987ee97 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=mzczLrHMPKtb7mxO4LwA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA4MDAxNSBTYWx0ZWRfX4sjeSucXeA7Y
 +gij8URVI3Pnw7bK4NQVxcQKNPT7b+DiTwllB4OtbtAWfRPucr88pyyzeYHizzOucrlEWyQ0EFR
 lu6xJQb9d70Qa/81Ep+3AJhvPCH5MuNWiBUPdYw8o4jhumVzm02zQBMnPKaXAjtud/Sp3MCf08F
 ScHnJ0vlMRKS6eOFZewCYXSzEx7/a8IpYT4sZT4Yy5Cs4IWn36nRdFSMEV3vcmi6UQOi3YmA6HE
 wFutTqkiL8MftFPbj4pcQkHfXMGdRRZt58h2hH3IrPavr4410XNgvzjbVDebaAFcoO4kTHDwN9/
 bD7JHorv3CHklY1n4wK0NlU+dnvU5IghCc4GJGNy0stDeHJYYSmxLOQVRdSHHoIVj/En69ZJ0jS
 MC9CyWisOBtxGg85elMlzLySp5+G3WfFIcGls5av3wYTZVVkLMSjeJbc9noS3N+cR2kOeOPc6Tj
 d/IroYJnZWM9pGtBxP50elOdHHmLyDiTas2pbLb0=
X-Proofpoint-ORIG-GUID: TvVVSfDdZyD8iuHaFu82ujwIbS3Vq0YC

On Fri, 23 Jan 2026 12:36:46 +0100, Sebastian Andrzej Siewior wrote:

> There was a bug report about setting IRQF_ONESHOT where it should have
> not been set. I looked around for other mistakes in that area. There are
> the following categories:
> 
> - Using custom primary irq handler doing exactly what
>   irq_default_primary_handler() does
> 
> [...]

Applied to 6.20/scsi-queue, thanks!

[07/21] scsi: efct: Use IRQF_ONESHOT and default primary handler
        https://git.kernel.org/mkp/scsi/c/1508301d4a47

-- 
Martin K. Petersen
